redo-ifchange rust-binaries
redo-ifchange $( cat rust-binaries ) "$2.remote-stamp"
cargo install --force "$2"
