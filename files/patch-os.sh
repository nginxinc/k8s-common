#!/bin/sh

skip_ssl=$1

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
    if [ -n "${skip_ssl}" ]; then
        apk upgrade --ignore \
            libssl3 libcrypto3 openssl openssl-dbg \
            openssl-doc openssl-dev openssl-libs-static \
            --no-cache -U
    else
        apk upgrade --no-cache -U
    fi
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
