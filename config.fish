# --- PATHs ---
set -Ux PATH /usr/bin /bin /usr/local/bin $PATH
set -Ux PATH /usr/share $PATH
set -Ux PATH (go env GOPATH)/bin $PATH
set -U fish_user_paths ~/.spicetify (go env GOPATH)/bin /usr/local/bin /usr/bin /bin

# --- Pyenv ---
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
status --is-interactive; and pyenv init - | source

# --- Fastfetch ---
type -q fastfetch; and fastfetch

# --- Starship ---
type -q starship; and starship init fish | source

# --- AGS terminal colors ---
if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
    cat ~/.cache/ags/user/generated/terminal/sequences.txt
end

# --- Aliases ---
alias pamcan=pacman

# --- Greeting ---
set fish_greeting

pyenv init - | source
