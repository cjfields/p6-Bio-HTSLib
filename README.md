# Bio-HTSLib

Initial NativeCall-based bindings to the htslib library for
high-throughput sequence analysis: 

https://github.com/samtools/htslib

# Targeted htslib version

The targeted tagged release of htslib is currently 1.1 and
is included as a submodule of this repository.  In order to
run a complete code checkout (including the submodules) use:

```
git clone --recursive https://github.com/cjfields/p6-Bio-HTSLib.git
```

Not sure if this will work with panda yet.

# Build and test

You should install panda first (https://github.com/tadzik/panda/).  Then

```
panda-build
panda-test
```

Alternatively one can also use @prove@:

```
panda-build
prove -e 'perl6' -lr t/
```