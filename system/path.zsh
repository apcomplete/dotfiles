BIN_PATH=./.bin:./bin

RUBY_PATH=vendor/ruby/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin

LOCAL_PATH=/usr/local/bin:/usr/local/sbin

ZSH_PATH=$ZSH/bin

export PATH=$BIN_PATH:$RUBY_PATH:$LOCAL_PATH:$ZSH_PATH:$PATH

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
