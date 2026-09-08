{ ... }:
{
  programs.git = {
    enable = true;
    userName = "wreckitral";
    userEmail = "defhanayasofhiea@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}
