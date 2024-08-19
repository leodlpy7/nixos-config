{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Leonard Delpy";
    userEmail = "leonard.delpy@gmail.com";
  };
}