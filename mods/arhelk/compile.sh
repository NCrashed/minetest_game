cd src
cabal sandbox init
cabal sandbox add-sources
cabal configure --extra-include-dirs=$(pwd)/../../../../../src
cabal install --dependencies-only
cabal build
cp dist/build/mod/libmod.so ../libmod.so
