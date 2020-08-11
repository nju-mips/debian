.PHONY: install-%

# download image from yun.baidu.com
# link: https://pan.baidu.com/s/1GJKpBK5Ccw5AZIg6Cy57lw
# code: n46u

debian.img:
	# sudo apt-get install debootstrap qemu-user-static
	dd if=/dev/zero of=$@ bs=512M count=1
	mkdir -p rootfs
	sudo mkfs.ext4 $@
	sudo mount $@ $(PWD)/rootfs -o loop
	sudo qemu-debootstrap --arch mipsel stretch rootfs http://deb.debian.org/debian/
	sudo umount rootfs

install-%: debian.img
	sudo mount $< $(PWD)/rootfs -o loop
	sudo chroot $(PWD)/rootfs apt-get install $(subst install-,,$@)
