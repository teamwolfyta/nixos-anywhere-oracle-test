# How to Launch

`nix build` since the disko build is aliased to the default package

sudo ./result --build-memory 32768

qemu-system-x86_64 \
        -m 8G \
        -machine type=q35,accel=kvm \
        -smp 8 \
        -drive format=raw,file=main.raw \
        -cpu host \
        -display default \
        -vga virtio \
        -bios /nix/store/ypfbsa465m41zyxkcdgqhlgc7j9411di-OVMF-202411-fd/FV/OVMF.fd
