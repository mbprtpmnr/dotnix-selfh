{ config, pkgs, ... }:

let 
  zsh-syntax-highlighting = pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "6e0e950154a4c6983d9e077ed052298ad9126144";
    sha256 = "09bkg1a7qs6kvnq17jnw5cbcjhz9sk259mv0d5mklqaifd0hms4v";
  };

  home = config.home.homeDirectory;

  powerlevel10k = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "543e2d59cf107af4e96727aa70d9f1ca93149f14";
    sha256 = "1ic8wynyrzgw95q0v37k7jd62ipi31nzvmkr98h9iya6h7g1i8iw";
  };
in

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    autocd = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      path = "${home}/.zsh_history";
    };
    shellAliases = {
      ls = "exa --color=always -l --group-directories-first";
      ll = "exa --color=always -al --group-directories-first";
      x="xclip -selection c -i";
      c="xclip -selection c -i -f";
      v="xclip -selection c -o";
    };

    plugins = [
      { name = "zsh-syntax-highlighting"; src = zsh-syntax-highlighting; }
      { name = "powerlevel10k"; src = powerlevel10k; }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "systemd" "pass" "otp" ];
    };

    initExtra = ''
      ${builtins.readFile ./nix-completions.sh}

      # fe() {
      #   rg --files ''${1:-.} | fzf --preview 'bat -f {}' | xargs $EDITOR
      # }

      # fl() {
      #   git log --oneline --color=always | fzf --ansi --preview="echo {} | cut -d ' ' -f 1 | xargs -I @ sh -c 'git log --pretty=medium -n 1 @; git diff @^ @' | bat --color=always" | cut -d ' ' -f 1 | xargs git log --pretty=short -n 1
      # }

      # gd() {
      #   git diff --name-only --diff-filter=d $@ | xargs bat --diff
      # }

      # cd() { builtin cd "$@" && ls . ; }
    '';

    initExtraBeforeCompInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${home}/.p10k.zsh 
    '';
  };
}
