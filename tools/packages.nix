{ pkgs ? import <nixpkgs> {} }:

[
    pkgs.gh
    pkgs.git
    pkgs.gnumake
    pkgs.gnuplot
    pkgs.go
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.rsync
    pkgs.wrk
]
