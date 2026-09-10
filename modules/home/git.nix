{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "wreckitral";
      user.email = "defhanayasofhiea@gmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
      core.editor = "nvim";
    };
  };
}
