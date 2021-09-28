{ config, pkgs, ... }:

{
  programs.bash.enable = true;
  programs.bash.historyControl = [
    "ignoredups"
  ];
  programs.bash.bashrcExtra = ''
    bind "set completion-ignore-case on"

    [[ -f ~/.profile ]] && . ~/.profile

    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

    fe() {
      rg --files ''${1:-.} | fzf --preview 'bat -f {}' | xargs $EDITOR
    }

    fl() {
      git log --oneline --color=always | fzf --ansi --preview="echo {} | cut -d ' ' -f 1 | xargs -I @ sh -c 'git log --pretty=medium -n 1 @; git diff @^ @' | bat --color=always" | cut -d ' ' -f 1 | xargs git log --pretty=short -n 1
    }

    gd() {
      git diff --name-only --diff-filter=d $@ | xargs bat --diff
    }

    cd() { builtin cd "$@" && ls . ; }

    se() {
      fileline=$(rg -n ''${1:-.} | fzf | awk '{print $1}' | sed 's/.$//')
      $EDITOR ''${fileline%%:*} +''${fileline##*:}
    }
  '';
  programs.bash.sessionVariables = {
    EDITOR = "vim";
  };
}
