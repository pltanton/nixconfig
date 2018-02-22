with import <nixpkgs> {};

{
  customRC = builtins.readFile ./vimrc;
  vam.knownPlugins = pkgs.vimPlugins;
  vam.pluginDictionaries = [
    { names = [
      "Tabular"
      "Syntastic"
      "neomake"
      "surround"
      "ctrlp"
      "fugitive"
      "deoplete-nvim"
      "vimtex"

      "vim-colorschemes"
    ]; }
    { names = [ "vim-go" "deoplete-go" ]; ft_regex = "^go$"; }
    { names = [ "deoplete-jedi" "flake8-vim" ]; ft_regex = "^python$"; }
    { name = "vim-addon-nix"; file_regex = "^nix$"; }
    { name = "vimtex"; ft_regex = "^tex$"; }
    { name = "ghcmod"; ft_regex = "^haskell$"; }
  ];
}
