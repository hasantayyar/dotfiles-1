# pw
# generate 10 chars password and save to file
# if exist, copy existing file to clipboard instead
# usage: pw $site-name

function pw {
  if [ -e ~/.pw/$1 ]; then
    cat ~/.pw/$1 | xclip -selection clipboard
  else
    cat /dev/urandom | tr -cd '[:graph:]' | fold -w 10 | head -n 1 > ~/.pw/$1
    cat ~/.pw/$1 | xclip -selection clipboard
  fi
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        # NAME=${1%.*}
        # mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

pip() {
  if [ "$1" = "install" -o "$1" = "bundle" ]; then
    cmd="$1"
    shift
    /usr/bin/pip $cmd --user "$@"
  else
    /usr/bin/pip "$@"
  fi
}
