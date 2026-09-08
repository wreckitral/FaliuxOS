{ username, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = username;
  wsl.docker-desktop.enable = true;
}
