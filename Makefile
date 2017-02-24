.PHONY: all
all: clean
	lb config \
		--apt-indices false
	sudo lb build 2>&1 | tee build.log

.PHONY: clean
clean:
	sudo lb clean
	-rm usb.img

usb.img:
	cp netkothos-amd64.hybrid.iso usb.img
	dd if=/dev/zero of=usb.img bs=1 count=0 seek=8G

test-iso:
	kvm -boot d -cdrom netkothos-amd64.hybrid.iso -m 512

test-usb:
	kvm -m 1024 usb.img
