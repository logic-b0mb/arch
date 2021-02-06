How to use the UART program downloader

Step 0: Connect the provided PmodUSBUART adapter to the top-most row of JB on the Nexys board.  JB is the PMOD connector in the bottom right corner of the board if oriented with the silkscreen text right side-up.


Step 1: Program the FPGA
The rest of the getting started documentation in Module 1 shows how to install Vivado, load the Single Cycle with Interrupts design, synthesize, and download the bitstream onto the FPGA.  At that point, the FPGA contains our CPU design, but it has no software loaded by default.  The rest of this guide shows how to download software for that CPU onto the Nexys board after bitstream download.


Step 2: Install the PIP package for Python 3
The fastest way to do this on modern Ubuntu, which is recommended for this class, is to run "sudo apt-get install python3-pip", which will install pip and any dependencies for you.  

Some python installs already come with pip, so you can try running "pip --version" or "pip3 --version" to see if you already have it.

For example:
$ pip3 --version
pip 20.2.4 from /usr/lib/python3.9/site-packages/pip (python 3.9)


Step 3: Install the required prerequisites
In this zip file, navigate to mips-cpu->Software->UART, e.g. "cd mips-cpu/Software/UART"
Now run pip against the requirements file provided by running "pip3 install -r requirements.txt":

$ pip3 install -r requirements.txt 
Defaulting to user installation because normal site-packages is not writeable
Collecting intelhex
  Using cached intelhex-2.3.0-py2.py3-none-any.whl (50 kB)
Collecting pyserial
  Using cached pyserial-3.5-py2.py3-none-any.whl (90 kB)
Successfully installed intelhex-2.3.0 pyserial-3.5


Step 4: Identify your USB-UART tty device

This step can be slightly tricky given our FPGA board and USB-UART adapater use a similar USB-UART chip, making identification harder.

One easy way to find the linux dev device (/dev/ttyUSB*) associated with the adapter is to unplug its USB cable, then plug it back in.  You can then run "dmesg" to see what the kernel did with the device.  For example on my system, reattaching the device resulted in:

$ sudo dmesg
<lots of text>
[95713.162977] usb 1-8: new full-speed USB device number 12 using xhci_hcd
[95713.511860] usb 1-8: New USB device found, idVendor=0403, idProduct=6001, bcdDevice= 6.00
[95713.511863] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[95713.511864] usb 1-8: Product: FT232R USB UART
[95713.511866] usb 1-8: Manufacturer: FTDI
[95713.511867] usb 1-8: SerialNumber: A904CXD3
[95713.534864] ftdi_sio 1-8:1.0: FTDI USB Serial Device converter detected
[95713.534882] usb 1-8: Detected FT232RL
[95713.542908] usb 1-8: FTDI USB Serial Device converter now attached to ttyUSB0

This last line in the log tells us Linux has placed our device at /dev/ttyUSB0, which we will use in the next step.


Step 5: Download the software

This is the only step you will need to routinely perform after loading an FPGA bitstream.

In the mips-cpu->Software->UART directory as before, there is a script "download-ihex.py" that interprets Intel Hex formatted data files and sends its content to the CPU over UART.  The provided "single_cycle_sw2led.ihex" is a tiny program for the Single Cycle CPU which takes the 16 switch positions and sets the corresponding LEDs.

After the CPU bitstream is loaded on the FPGA, this program can be downloaded by running "./download-ihex.py /dev/ttyUSB0 single_cycle_sw2led.ihex" from the UART directory, making sure to substitute "ttyUSB0" for your appropriate device if different.

An example of this is:
$ ./download-ihex.py /dev/ttyUSB0 single_cycle_sw2led.ihex
h
i
a 00000000
w 3c0cbf80
a 00000004
w 358d0004
a 00000008
w 8daa0000
a 0000000c
w ad8a0000
a 00000010
w 1000fffd
a 00000014
w 00000000
e
g

If all goes well, the LEDs will take on the switch positions.  Internally, the download mechanism is a simple command set sent to a monitor state-machine in the fpga (cmdproc.v) which takes characters like "w 3c0cbf80" and converts them into bus cycles to write data into RAM.

The entire stack of Python and Verilog is open-source and reasonably small, so poke around and see how it works.
