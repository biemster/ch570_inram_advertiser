all : clean runfromram

TARGET:=broadcaster
TARGET_MCU:=CH570
TARGET_MCU_PACKAGE:=CH570D

LINKER_SCRIPT:=app_in_ram.ld

include ../ch32fun/ch32fun/ch32fun.mk

flash : runfromram

runfromram : $(TARGET).bin
	# Halt, Reboot, Disable Autoexec, Write RAM, DATA0 = RAM Start, Write DATA0 to DPC, Resume
	$(MINICHLINK)/minichlink -ks 0x10 0x80000001 -s 0x10 0x80000003 -s 0x18 0 -w $(TARGET).bin 0x20000000 -s 0x04 0x20000000 -s 0x17 0x002307b1 -s 0x10 0x40000001 -T # Resume Request

clean : cv_clean

