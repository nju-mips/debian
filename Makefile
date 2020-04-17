.PHONY: install-%

debian.img:
	dd if/dev/zero of=$@ bs=512M count=1
	mkdir -p rootfs
	sudo mount $@ $(PWD)/rootfs -o loop
	sudo qemu-debootstrap --arch mipsel stretch rootfs http://deb.debian.org/debian/
	sudo umount rootfs

install-%: debian.img
	sudo mount $< $(PWD)/rootfs -o loop
	sudo chroot $(PWD)/rootfs apt-get install $(subst install-,,$@)
