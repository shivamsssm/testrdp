read -p $'\e[1;37mEnter your ngrok token: \e[0m' token
sudo apt update -y
sudo apt install apache2 ufw p7zip-full qemu-system-x86-64 -y
sudo ufw allow 'VNC'
sudo ufw status
if [ -e "./win10.vhd" ]; then
    echo "File exists"
else
 
    
fi
if [ -e "./ngrok" ]; then
    echo "File exists"
else
    wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
    tar -xvzf ngrok-v3-stable-linux-amd64.tgz
    rm -rf ngrok-v3-stable-linux-amd64.tgz
fi
./ngrok authtoken "$token"
rungrok="$(./ngrok tcp 5900)" &
clear
echo "----------\/----------"
echo "Please go to the following link to check if the generated address is working and connect using VNC: https://dashboard.ngrok.com/agents"
echo "----------/\----------"
sleep 5
sudo qemu-system-x86_64 -cpu core2duo,+avx -usb -device usb-kbd -device usb-tablet -smp sockets=1,cores=4,threads=1 -m 10G -hda win10.vhd -vga vmware -device ac97 -device e1000,netdev=n0 -netdev user,id=n0 -accel tcg,thread=multi,tb-size=2048 -vnc :0
clear
echo "To run again, run the following command:"
echo "----------\/----------"
echo "rungrok="\$\(./ngrok tcp 5900\)" & sudo qemu-system-x86_64 -cpu core2duo,+avx -usb -device usb-kbd -device usb-tablet -smp sockets=1,cores=4,threads=1 -m 10G -hda win10.vhd -vga vmware -device ac97 -device e1000,netdev=n0 -netdev user,id=n0 -accel tcg,thread=multi,tb-size=2048 -vnc :0"
echo "----------/\----------"
