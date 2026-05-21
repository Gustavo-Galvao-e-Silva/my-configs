export JAVA_HOME=/opt/homebrew/opt/openjdk@11/libexec
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
alias python='python3.14'
alias pip='pip3'

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

autoload -Uz compinit
compinit

bindkey '^I' menu-complete

bindkey '^[[C' autosuggest-accept
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format 'Completing %d'

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_TITLE="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
eval "$(direnv hook zsh)"

py-setup() {
    local project_name="$1"
    shift 

    if [[ -z "$project_name" || "$project_name" == -* ]]; then
        echo "Error: Please provide a project name first."
        echo "Usage: py-setup project_name [--req 'pkg1 pkg2']"
        return 1
    fi

    local requirements opt
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --req|--requirements)
                requirements="$2"
                shift 2
                ;;
            *)
                echo "Unknown option: $1"
                return 1
                ;;
        esac
    done

    if [ ! -d "$project_name" ]; then
        echo "Creating project directory..."
        mkdir -p "$project_name"
    fi
    cd "$project_name"

    echo "Initializing uv project..."
    uv init --no-workspace --name "$project_name"

    if [[ -n "$requirements" ]]; then
        echo "Adding packages: $requirements..."
        uv add $=requirements 
    fi

    if [ ! -d ".venv" ]; then
        uv venv
    fi
    
    source .venv/bin/activate

    echo "# $project_name" > README.md
    echo "Started on $(date +'%Y-%m-%d')" >> README.md

    cat <<EOF > .gitignore
# Python
__pycache__/
*.py[cod]
.venv/
.python-version

# Distribution / packaging
dist/
build/
*.egg-info/

# MacOS Files
.DS_Store

# Vim fzf setup
.ignore

# Local env files
.env
EOF
    
    cat <<EOF > .ignore
__pycache__/
*.py[cod]
*.egg-info/
EOF

    if [ ! -d ".git" ]; then
        echo "Initiating Git repository..."
        git init
    fi

    echo "✅ Setup complete for '$project_name'."
}

java-check() {
    local file_name=$1
    java -jar ~/Downloads/checkstyle-8.28.jar "$file_name"
}

source <(fzf --zsh)
fzf-file-widget() {
  LBUFFER="${LBUFFER}$(find . -maxdepth 2 -not -path '*/.*' | fzf --height 40% --reverse)"
  zle reset-prompt
}
zle -N fzf-file-widget
bindkey '^P' fzf-file-widget
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
