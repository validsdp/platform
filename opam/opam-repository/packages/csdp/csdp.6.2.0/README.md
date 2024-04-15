# Test d'installation d'openblas sous macOS (maintenant désinstallé)

    + /opt/homebrew/bin/brew "install" "openblas"
    - ==> Fetching openblas
    - ==> Downloading https://ghcr.io/v2/homebrew/core/openblas/manifests/0.3.23
    - Already downloaded: /Users/emartin/Library/Caches/Homebrew/downloads/b69590a17de16f9d7b908e05443e8f43eb69678cf7eb70e73b7f067bc5637313--openblas-0.3.23.bottle_manifest.json
    - ==> Downloading https://ghcr.io/v2/homebrew/core/openblas/blobs/sha256:e43a93b3c2ccb704d431d9a624f01e05aa464bd3287b115b1d9a476db0f48b8a
    - Already downloaded: /Users/emartin/Library/Caches/Homebrew/downloads/8bdfeae3429e3ec3bbc0ef17a7f24d60b54e8b02c80b91a3e78ceb653cc1cca0--openblas--0.3.23.arm64_ventura.bottle.tar.gz
    - ==> Pouring openblas--0.3.23.arm64_ventura.bottle.tar.gz
    - ==> Caveats
    - openblas is keg-only, which means it was not symlinked into /opt/homebrew,
    - because macOS provides BLAS in Accelerate.framework.
    - 
    - For compilers to find openblas you may need to set:
    -   export LDFLAGS="-L/opt/homebrew/opt/openblas/lib"
    ‘{-   export CPPFLAGS="-I/opt/homebrew/opt/openblas/include"
    - 
    - For pkg-config to find openblas you may need to set:
    -   export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig"
    - ==> Summary
    - 🍺  /opt/homebrew/Cellar/openblas/0.3.23: 23 files, 56.6MB
    - ==> Running `brew cleanup openblas`...
    - Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
    - Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
    
    <><> Processing actions <><><><><><><><><><><><><><><><><><><><><><><><><><>  🐫 
    ⬇ retrieved csdp.6.2.0  (cached)
    ⊘ removed   conf-openblas-macOS-env.1
    ⊘ removed   conf-openblas.0.2.2
    ∗ installed conf-openblas.0.2.2
    ∗ installed conf-openblas-macOS-env.1

# Erreur actuelle sous macOS

    - cc -m64 -march=native -mtune=native -Ofast -Xpreprocessor -fopenmp -I/opt/homebrew/opt/libomp/include  -Wall -DBIT64 -DUSEOPENMP -DSETNUMTHREADS -DUSESIGTERM -DUSEGETTIME -I../include   -c -o user_exit.o user_exit.c
    - user_exit.c:27:3: error: call to undeclared library function 'printf' with type 'int (const char *, ...)'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    -   printf("Process stopped by signal.\n");
    -   ^
    - user_exit.c:27:3: note: include the header <stdio.h> or explicitly provide a declaration for 'printf'
    - user_exit.c:24:6: warning: a function declaration without a prototype is deprecated in all versions of C and is not supported in C2x [-Wdeprecated-non-prototype]
