# How to Launch

qemu-system-x86_64 \
        -m 1G \
        -machine type=q35,accel=kvm \
        -smp 1 \
        -drive format=raw,file=main.raw \
        -cpu host \
        -display default \
        -vga virtio \
        -bios /nix/store/ypfbsa465m41zyxkcdgqhlgc7j9411di-OVMF-202411-fd/FV/OVMF.fd
