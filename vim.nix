{ nixpkgs ? import <nixpkgs> {} }:

let
  myVim = nixpkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./vimrc;

    vimrcConfig.packages.myVimPackage = with nixpkgs.vimPlugins; {
        start = [
          vim-colorschemes 
          rainbow_parentheses
          # syntastic
          vimproc
          ctrlp
          neocomplete
          The_NERD_Commenter
          The_NERD_tree
          supertab
          tabular
          tlib
          vim-addon-mw-utils
          vim-repeat
          snipmate
          surround
          rust-vim
          ghcmod
          neco-ghc
          vim-nix
          fugitive
          vim-airline
          ale
      ];

      #opt = [
      #  rust-vim
      #  ghcmod
      #  neco-ghc
      #  vim-nix
      #];
    };
  };
in
{
  vim = myVim; 
  environment.systemPackages = [ myVim ];
  environment.shellAliases.vi = "vim";
  environment.variables.EDITOR = "vim";
  programs.bash.shellAliases = {
    vi = "vim";
    svim = "sudoedit";
  };
  nixpkgs.config.vim.ftNix = false;
}
