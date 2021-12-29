
install curl

apt-get curl

install font ubuntu
cd /home
mkdir dependencies
cd dependencies
curl http://ftp.de.debian.org/debian/pool/non-free/f/fonts-ubuntu/fonts-ubuntu_0.83-4_all.deb -o fontubuntu.deb
dpkg -i fontubuntu.deb

curl http://ftp.de.debian.org/debian/pool/non-free/f/fonts-ubuntu/ttf-ubuntu-font-family_0.83-4_all.deb -o ttfubuntu.deb
dpkg -i ttfubuntu.deb

apt-get install libc6

curl http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb -o libjpeg.deb

dpkg -i libjpeg.debs

curl http://archive.ubuntu.com/ubuntu/pool/universe/e/enchant/libenchant1c2a_1.6.0-11.3build1_amd64.deb -o libenchant1c2a.deb

&& dpkg -i libenchant1c2a.deb

apt --fix-broken install

curl http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu66_66.1-2ubuntu2_amd64.deb -o libicu66.deb

dpkg -i libicu66

npx playwright install-deps