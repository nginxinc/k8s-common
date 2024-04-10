#!/bin/sh

patch_debian() {
    echo "Patching Debian"
    apt-get update
    apt-get upgrade -y 
    rm -rf /var/lib/apt/lists/*
}

patch_ubi_dnf() {
    echo "Patching UBI dnf"
    DNF=""
    if [ -f /usr/bin/microdnf ]; then
        DNF=/usr/bin/microdnf
    else
        DNF=/usr/bin/dnf
    fi
    ${DNF} update -y
    ${DNF} clean all

}

patch_alpine() {
    echo "Patching Alpine"
    apk upgrade --no-cache -U
}

if [ ! -f /etc/os-release ]; then
    echo "ERROR: cannot find /etc/os-release, cannot continue."
    exit 1
fi

. /etc/os-release

case ${ID} in
   "debian")
      patch_debian
      ;;
   "rhel")
      patch_ubi_dnf
      ;;
   "alpine")
      patch_alpine
      ;;
   *)
     echo "ERROR: unsupported OS [${ID}]"
     exit 1
     ;;
esac
