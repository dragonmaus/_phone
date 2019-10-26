redo-ifchange "$2.local-stamp"
cd "$2"
cargo clean
cargo install --force --frozen --offline --path=.
cargo clean
