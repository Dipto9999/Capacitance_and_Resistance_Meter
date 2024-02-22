########################
### Import Packages ###
########################

import datetime as dt

import pandas as pd
import numpy as np
from IPython.display import display

import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import matplotlib.animation as animation

import tkinter as tk
from tkinter import ttk

import serial
import sys

###############
### Classes ###
###############

class Serial(serial.Serial) :
    def __init__(self,
            port = 'COM3',
            baudrate = 115200,
            parity = serial.PARITY_NONE,
            stopbits = serial.STOPBITS_ONE,
            bytesize = serial.EIGHTBITS
        ):
        super().__init__(
            port = port,
            baudrate = baudrate,
            parity = parity,
            stopbits = stopbits,
            bytesize = bytesize,
        )

        if self.isOpen() :
            print('Serial Port is Open')
        else:
            print('Serial Port is Closed')

    def close(self) :
        super().close()

class StripChart :
    def __init__(self, master, conn = None, xlim = 1500) :
        self.master = master
        self.conn = conn
        self.fig = plt.figure()

        self.ax = self.fig.add_subplot(111)
        self.ax.set_title('Capacitance Strip-Chart')

        self.xlim = xlim
        self.ax.set_xlim(0, self.xlim)
        self.ax.set_xlabel('Samples')

        # self.ax.set_ylim(0, 1000)
        self.ax.set_ylabel('Capacitance (pF)')

        self.ax.grid()

        self.capacitance_line, = self.ax.plot([], [], lw = 2, label = 'Capacitance (pF)')
        self.frequency_line, = self.ax.plot([], [], lw = 2, label = 'Frequency (kHz)')

        self.ax.legend(loc = 'upper right')

        self.current_val, self.current_type = 0, 'C'

        self.t_data, self.capacitance_data, self.frequency_data = [], [], []
        self.data_df = pd.DataFrame(columns = ['Datetime', 'Capacitance (pF)'])

        self.canvas = FigureCanvasTkAgg(self.fig, master = self.master)
        self.canvas_widget = self.canvas.get_tk_widget()
        # self.canvas_widget.grid(row = 0, column = 0, sticky = 'nsew')
        self.canvas_widget.pack(fill = tk.BOTH, expand = True)

    def read_serial(self) :
        capacitance_indicator = 'C(pF)= '
        frequency_indicator = 'F(kHz)= '
        if (self.conn is not None) :
            rx_val = self.conn.readline().decode('utf-8').strip('\r\n')

            if (rx_val.find(capacitance_indicator) > -1) :
                return 'C', rx_val.replace(capacitance_indicator, '')
            elif (rx_val.find(frequency_indicator) > -1) :
                return 'F', rx_val.replace(frequency_indicator, '')

        return None, -1

    def data_gen(self):
        t = -1
        while True :
            t += 1

            rx_data = self.read_serial()
            if rx_data[0] is not None :
                try :
                    self.current_val, self.current_type = float(rx_data[1]), rx_data[0]
                except (TypeError, ValueError, UnicodeDecodeError) :
                    print("Error Reading Capacitance/Frequency From Serial Port!")
                finally :
                    current_val, current_type = self.current_val, self.current_type
                current_time = dt.datetime.now()
            yield t, current_type, current_val, current_time

    def run(self, data):
        # t, y, current_time = data
        t, current_type, current_val, current_time = data
        if t > -1 :
            if current_type == 'C' :
                self.t_data.append(t)
                self.capacitance_data.append(current_val)
            elif current_type == 'F' :
                self.t_data.append(t)
                self.frequency_data.append(current_val)

            if t > self.xlim :
                self.ax.set_xlim(t - self.xlim, t)
            self.capacitance_line.set_data(self.t_data, self.capacitance_data)
            self.frequency_line.set_data(self.t_data, self.frequency_data)

            new_df = pd.DataFrame({
                'Datetime': current_time,
                'Capacitance': current_val if (current_type == 'C') else np.nan,
                'Frequency': current_val if (current_type == 'F') else np.nan
            })

            if self.data_df.empty :
                self.data_df = new_df
            else:
                self.data_df = pd.concat([self.data_df, new_df], ignore_index = True, axis = 0).ffill()
            self.current_val, self.current_type = current_val, current_type
        return self.line

    def start_animation(self, conn):
        self.conn = conn
        self.animation = animation.FuncAnimation(
            fig = self.fig,
            func = self.run,
            frames = self.data_gen,
            blit = False,
            interval = 120,
            repeat = False,
            save_count = 10  # Adjust this value as needed
        )
        self.canvas = FigureCanvasTkAgg(self.fig, master = self.master)
        self.canvas_widget = self.canvas.get_tk_widget()
        self.canvas_widget.grid(row = 0, column = 0)

    def export_csv(self) :
        if not self.data_df.empty :
            csv_df = self.data_df.copy()

            csv_df = csv_df.groupby('Datetime').mean().reset_index(
                drop = False
            )
            csv_df['Datetime'] = csv_df['Datetime'].dt.strftime('%Y-%m-%d %H:%M:%S')
            csv_df.rename(
                columns = {
                    'Datetime': 'Datetime',
                    'Capacitance': 'Capacitance (pF)',
                    'Frequency': 'Frequency (kHz)'
                }, inplace = True
            )
            csv_path = f'''LogBook/EFM8_{csv_df['Datetime'].iloc[0].replace(' ', '_').replace('-', '_').replace(':', '_')}.csv'''
            csv_df.to_csv(csv_path, index = False)

            print(f"Data Exported to {csv_path}\n\nData Preview:\n")
            display(csv_df.head(2))

class App :
    def _config_serial_frame(self, window) :
        self.serial_frame = tk.Frame(window, bg = 'lightgrey')

        # Create Serial Frame Widgets
        self.port_label = tk.Label(self.serial_frame, text = "Serial Line : ", bg = 'lightgrey')
        self.port_entry = tk.Entry(self.serial_frame, bg = 'lightblue')
        self.port_entry.insert(0, 'COM3')

        self.baudrate_label = tk.Label(self.serial_frame, text = "Speed : ", bg = 'lightgrey')
        self.baudrate_entry = tk.Entry(self.serial_frame, bg = 'lightblue')
        self.baudrate_entry.insert(0, '115200')

        self.parity_label = tk.Label(
            self.serial_frame, text = "Parity : ", bg = 'lightgrey'
        )
        self.parity_combobox = ttk.Combobox(
            self.serial_frame,
            values = [
                'PARITY_NONE', 'PARITY_EVEN', 'PARITY_ODD',
                'PARITY_MARK', 'PARITY_SPACE'
            ]
        )
        self.parity_combobox.set('PARITY_NONE')

        self.stopbits_label = tk.Label(
            self.serial_frame, text = "Stop Bits : ", bg = 'lightgrey'
        )
        self.stopbits_combobox = ttk.Combobox(
            self.serial_frame,
            values = ['STOPBITS_ONE', 'STOPBITS_ONE_POINT_FIVE', 'STOPBITS_TWO'],
        )
        self.stopbits_combobox.set('STOPBITS_ONE')

        self.bytesize_label = tk.Label(
            self.serial_frame, text = "Byte Size : ", bg = 'lightgrey'
        )
        self.bytesize_combobox = ttk.Combobox(
            self.serial_frame,
            values = ['FIVEBITS', 'SIXBITS', 'SEVENBITS', 'EIGHTBITS'],
        )
        self.bytesize_combobox.set('EIGHTBITS')

        self.open_button = tk.Button(
            self.serial_frame, text = "Open", command = self.open_serial, bg = 'lightblue',
        )
        # self.send_button = tk.Button(
        #     self.serial_frame,
        #     text = "Send N76E003(C)", command = lambda : self.send_serial(
        #         f'{int(self.test_chart.current_val*(10**4))}'
        #     ),
        #     bg = 'lightblue'
        # )

        # Position Serial Frame Widgets
        self.port_label.grid(
            row = 0, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.port_entry.grid(
            row = 0, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.baudrate_label.grid(
            row = 1, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.baudrate_entry.grid(
            row = 1, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.parity_label.grid(
            row = 2, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.parity_combobox.grid(
            row = 2, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.stopbits_label.grid(
            row = 3, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.stopbits_combobox.grid(
            row = 3, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.bytesize_label.grid(
            row = 4, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.bytesize_combobox.grid(
            row = 4, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.open_button.grid(
            row = 5, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10,
            sticky = 'e'
        )
        # self.send_button.grid(
        #     row = 5, column = 1,
        #     rowspan = 1, columnspan = 1,
        #     padx = 10, pady = 10
        # )

        window.add(self.serial_frame)

    def _config_reference_frame(self, window) :
        self.reference_frame = tk.Frame(self.left_window, bg = 'lightgrey')
        self.design_frame = tk.Frame(self.reference_frame, bg = 'lightgrey')
        self.estimations_frame = tk.Frame(self.reference_frame, bg = 'lightgrey')

        # Create Design Frame Widgets
        self.capacitance_label = tk.Label(self.design_frame, text = f"Capacitance (μF) : ", bg = 'lightgrey')
        self.capacitance_entry = tk.Entry(self.design_frame, bg = 'lightblue')
        self.capacitance_entry.insert(0, self.capacitance / (10**(-6)))

        self.resistance_A_label = tk.Label(self.design_frame, text = f"Resistance A (Ω) : ", bg = 'lightgrey')
        self.resistance_A_entry = tk.Entry(self.design_frame, bg = 'lightblue')
        self.resistance_A_entry.insert(0, self.R_A)

        self.resistance_B_label = tk.Label(self.design_frame, text = f"Resistance B (Ω) : ", bg = 'lightgrey')
        self.resistance_B_entry = tk.Entry(self.design_frame, bg = 'lightblue')
        self.resistance_B_entry.insert(0, self.R_B)

        self.estimate_freq_button = tk.Button(
            self.design_frame, text = "Estimate Frequency", command = self.reestimate_freq, bg = 'lightblue'
        )
        # Position Design Frame Widgets
        self.capacitance_label.grid(
            row = 0, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.capacitance_entry.grid(
            row = 0, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.resistance_A_label.grid(
            row = 1, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.resistance_A_entry.grid(
            row = 1, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.resistance_B_label.grid(
            row = 2, column = 0,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'w'
        )
        self.resistance_B_entry.grid(
            row = 2, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        self.estimate_freq_button.grid(
            row = 3, column = 1,
            rowspan = 1, columnspan = 1,
            padx = 10, pady = 10, sticky = 'e'
        )

        # Create Estimations Frame Widgets
        self.estimation_title_label = tk.Label(
            self.estimations_frame,
            text = f"\nExpected Values",
            bg = 'lightgrey',
            font = tk.font.Font(family = "Helvetica", size = 25, weight = "bold")
        )
        self.estimation_values_label = tk.Label(
            self.estimations_frame,
            text = f"C: {round(self.capacitance / (10**(-6)), 2)} μF\n"\
                + f"Freq: {round(self.expected_freq / (10**(3)), 2)} kHz\n",
            bg = 'lightgrey',
            font = tk.font.Font(family = "Helvetica", size = 20)
        )

        # Position Estimation Frame Widgets
        self.estimation_title_label.pack(padx = 10, pady = 10)
        self.estimation_values_label.pack(padx = 10, pady = 10)

        self.design_frame.pack(padx = 10, pady = 10)
        self.estimations_frame.pack(padx = 10, pady = 10)

        window.add(self.reference_frame)

    def _config_stripchart_frame(self, window) :
        self.test_chart_frame = tk.Frame(self.right_window, bg = 'grey')

        # Initialize StripChart in the StripChart frame
        self.test_chart = StripChart(self.test_chart_frame)
        self.export_csv_button = tk.Button(
            self.root,
            text = "Export to Spreadsheet", command = self.test_chart.export_csv,
            bg = 'lightblue'
        )
        self.save_button = tk.Button(
            self.root,
            text = "Save Figure", command = self.save_fig,
            bg = 'lightblue'
        )

        # Position StripChart Frame Widgets
        self.save_button.pack(
            padx = 10, pady=10, side = tk.RIGHT
        )
        self.export_csv_button.pack(
            padx = 10, pady = 10, side = tk.RIGHT
        )

        window.add(self.test_chart_frame)

    def __init__(self, capacitance = 0.1 * (10**(-6)), R_A = 2.5 * (10**3), R_B = 2.5 * (10**3)) :
        self.root = tk.Tk()
        self.root.configure(
            background = 'black',
            padx = 10, pady = 10
        )
        self.root.geometry("1200x755")
        self.root.resizable(False, False)
        self.root.title("Capacitance Strip-Chart")
        # Bind Close Function to Window Close Event
        self.root.protocol("WM_DELETE_WINDOW", self.close)

        self.conn = None  # # Initialize Serial Connection to None

        self.estimate_freq(capacitance, R_A, R_B)

        self.main_window = ttk.PanedWindow(self.root, orient = tk.HORIZONTAL)
        self.main_window.pack(fill = tk.BOTH, expand = True)

        self.left_window = ttk.PanedWindow(self.main_window, orient = tk.VERTICAL)
        self.right_window = ttk.PanedWindow(self.main_window, orient = tk.VERTICAL)

        self.left_window.pack(fill = tk.BOTH, expand = True)
        self.right_window.pack(fill = tk.BOTH, expand = True)

        self._config_serial_frame(self.left_window)
        self._config_reference_frame(self.left_window)
        self._config_stripchart_frame(self.right_window)

        self.main_window.add(self.left_window)
        self.main_window.add(self.right_window)

        self.root.mainloop()

    def close(self) :
        self.test_chart.export_csv()
        if self.conn is not None :
            self.conn.close()
        self.root.destroy()
        sys.exit()

    def estimate_freq(self, capacitance, R_A, R_B) :
        self.capacitance = capacitance
        self.R_A, self.R_B = R_A, R_B

        self.expected_freq = (1.44 / (self.capacitance * (self.R_A + 2 * self.R_B)))

        print(f"Design Values: C: {self.capacitance} F, R_A: {self.R_A} Ω, R_B: {self.R_B} Ω")
        print(f"Expected Frequency: {self.expected_freq} Hz")

    def reestimate_freq(self) :
        try :
            new_capacitance = float(self.capacitance_entry.get()) * (10**(-6))
            new_R_A = float(self.resistance_A_entry.get())
            new_R_B = float(self.resistance_B_entry.get())

            self.estimate_freq(new_capacitance, new_R_A, new_R_B)
        except ValueError as e :
            print(f"Error Estimating Frequency\n {e}")
        finally :
            self.estimation_values_label.config(
                text = f"C: {round(self.capacitance / (10**(-6)), 2)} μF\n"\
                    + f"Freq: {round(self.expected_freq / (10**(3)), 2)} kHz\n"
            )

    def open_serial(self):
        if self.conn is None :  # Check if Serial Connection Already Established
            port = self.port_entry.get()
            baudrate = self.baudrate_entry.get()

            parity = serial.PARITY_EVEN if self.parity_combobox.get() == 'PARITY_EVEN'\
                else serial.PARITY_ODD if self.parity_combobox.get() == 'PARITY_ODD'\
                else serial.PARITY_MARK if self.parity_combobox.get() == 'PARITY_MARK'\
                else serial.PARITY_SPACE if self.parity_combobox.get() == 'PARITY_SPACE'\
                else serial.PARITY_NONE

            stopbits = serial.STOPBITS_ONE_POINT_FIVE if self.stopbits_combobox.get() == 'STOPBITS_ONE_POINT_FIVE'\
                else serial.STOPBITS_TWO if self.stopbits_combobox.get() == 'STOPBITS_TWO'\
                else serial.STOPBITS_ONE

            bytesize = serial.FIVEBITS if self.bytesize_combobox.get() == 'FIVEBITS'\
                else serial.SIXBITS if self.bytesize_combobox.get() == 'SIXBITS'\
                else serial.SEVENBITS if self.bytesize_combobox.get() == 'SEVENBITS'\
                else serial.EIGHTBITS

            try :
                self.conn = Serial(
                    port = port, baudrate = int(baudrate),
                    parity = parity, stopbits = stopbits, bytesize = bytesize
                )

                self.test_chart.start_animation(conn = self.conn) # Start Animation
            except Exception as e :
                print(f"Error Opening Serial Port\n {e}")

    def save_fig(self) :
        jpg_path = f'''Figures/EFM8_{dt.datetime.now().strftime('%Y_%m_%d_%H_%M_%S')}.jpg'''
        self.test_chart.fig.savefig(jpg_path, 'test_chart.jpg', format = 'jpg', dpi = 800)
        print(f"Figure Saved As {jpg_path}")

    def send_serial(self, temp_parsed) :
        if self.conn is not None :
            num_send = len(temp_parsed) // 2

            for i in range(num_send) :
                curr_byte = hex(int(temp_parsed[i*2 : i*2+2]))
                print(f"Sending {curr_byte}")
                self.conn.write(curr_byte.encode('utf-8'))

if __name__ == "__main__":
    app = App(
        capacitance = 0.1 * (10**(-6)), R_A = 1.667 * (10**3), R_B = 1.667 * (10**3)
    )
