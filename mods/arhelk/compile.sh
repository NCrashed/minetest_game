cd src
cabal sandbox init
cabal install --dependencies-only
cabal build
cp dist/build/mod/libmod.so ../libmod.so
