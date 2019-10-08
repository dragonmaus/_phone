redo-ifchange all.list

tr '\n' '\0' < all.list | xargs -0 redo-ifchange
