BIN_PATH=./.bin:./bin:~/.asdf/bin

RUBY_PATH=vendor/ruby/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin

NPM_PATH=./node_modules/.bin:$HOME/.npm-packages/bin:/usr/local/share/npm/bin

LOCAL_PATH=/usr/local/bin:/usr/local/sbin

NVIM_PATH=~/.local/share/nvim/mason/bin

export PATH=$RUBY_PATH:$NVIM_PATH:$NPM_PATH:$BIN_PATH:$LOCAL_PATH:$HOME/.local/bin:$PATH

export PROJECTS=~/Projects

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

export EDITOR='nvim -N'

# KERL config for setting up erlang
export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --disable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit"

