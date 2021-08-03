GPPARAMS = -m32 -fno-stack-protector -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386
objects = loader.o port.o gdt.o interruptstubs.o interrupts.o kernel.o

%.o : %.cpp
	gcc $(GPPARAMS) -o $@ -c $<

%.o : %.s
	as $(ASPARAMS) -o $@ $<
loader.o : loader.s
	as $(ASPARAMS) -o $@ $<


mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: mykernel.bin
				sudo cp $< /boot/mykernel.bin

mykernel.iso: mykernel.bin
	mkdir iso
	mkdir iso/boot
	mkdir iso/boot/grub
	mkdir -p iso/boot/grub
	cp  mykernel.bin iso/boot/mykernel.bin

	echo 'set timeout = 0' > iso/boot/grub/grub.cfg
	echo 'set default=0' >> iso/boot/grub/grub.cfg

	echo '' >> iso/boot/grub/grub.cfg
	echo 'menuentry "Myos" {' >> iso/boot/grub/grub.cfg

	echo 'multiboot /boot/mykernel.bin' >> iso/boot/grub/grub.cfg
	
	echo 'boot' >> iso/boot/grub/grub.cfg
	
	echo '}' >> iso/boot/grub/grub.cfg
	
	grub-mkrescue --output=$@ iso
	rm -rf iso

run: mykernel.iso
	(killall VirutalBox && sleep 1) || true 
	VirtualBox --startvm "Myos" & 
.PHONY: clean
clean: 
				rm -f $(objects) mykernel.bin mykernel.iso
