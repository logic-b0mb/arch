Step 0: Pull the latest changes from the consolidated branch
-------------------------
Step 1: Open terminal
Step 2: Make sure the mips-mti-elf toolchain is in your PATH variable (e.g. try running "mips-mti-elf-gcc". This should already be done, but you can do it for this terminal session only with "set PATH=<bla\mips-mti-elf\2019.09-01\bin>;%PATH%")
Step 3: Run Software\Assembly\makesystem\winenv.bat to add Make and other tools to path for this session only
Step 4: Try building some software (e.g. run "make split_i_d_mem" in the SwitchLED7Seg folder)