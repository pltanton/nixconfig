with import <nixpkgs> {};

{
  customRC = builtins.readFile ./vimrc;
  vam.knownPlugins = pkgs.vimPlugins;
  vam.pluginDictionaries = [
    { names = [
      "Tabular"
      "surround"

      "neomake"
      "deoplete-nvim"

      "The_NERD_tree"
      "ctrlp"
      "fugitive"
      "undotree"

      "vimtex"

      "airline"
      "vim-colorschemes"
      "vim-airline-themes"
    ]; }
    { names = [ "vim-go" "deoplete-go" ]; ft_regex = "^go$"; }
    { names = [ "flake8-vim" "deoplete-jedi" ]; ft_regex = "^python$"; }
    { name = "vim-addon-nix"; file_regex = "^nix$"; }
    { name = "vimtex"; ft_regex = "^tex$"; }
    { names = [ "ghcmod" "neco-ghc" ]; ft_regex = "^haskell$"; }
  ];
}
