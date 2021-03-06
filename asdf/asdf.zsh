autoload -Uz compinit && compinit

export KERL_CONFIGURE_OPTIONS="--disable-debug --disable-silent-rules --without-javac --enable-shared-zlib --enable-dynamic-ssl-lib --enable-hipe --enable-sctp --enable-smp-support --enable-threads --enable-kernel-poll --enable-wx --enable-darwin-64bit --with-ssl=/usr/local/opt/openssl"

export PATH=~/.asdf/bin:$PATH

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
