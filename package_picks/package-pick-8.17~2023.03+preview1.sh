#!/usr/bin/env bash

###################### COPYRIGHT/COPYLEFT ######################

# (C) 2020..2022 Michael Soegtrop

# Released to the public under the
# Creative Commons CC0 1.0 Universal License
# See https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt

###################### CONTROL VARIABLES #####################

# The two lines below are used by the package selection script
COQ_PLATFORM_VERSION_TITLE="Coq 8.17+rc1 (released Dec 2022) with the first package pick from Feb 2023"
COQ_PLATFORM_VERSION_SORTORDER=99

# The package list name is the final part of the opam switch name.
# It is usually either empty ot starts with ~.
# It might also be used for installer package names, but with ~ replaced by _
# It is also used for version specific file selections in the smoke test kit.
COQ_PLATFORM_PACKAGE_PICK_POSTFIX='~8.17~2023.03+preview1'

# The corresponding Coq development branch and tag
COQ_PLATFORM_COQ_BRANCH='v8.17'
COQ_PLATFORM_COQ_TAG='8.17+rc1'

# This controls if opam repositories for development packages are selected
COQ_PLATFORM_USE_DEV_REPOSITORY='Y'

# This extended descriptions is used for readme files
COQ_PLATFORM_VERSION_DESCRIPTION='This version of Coq Platform 2023.03+preview1 includes Coq 8.17+rc1 from Dec 2022. '
COQ_PLATFORM_VERSION_DESCRIPTION+='This is an incomplete previewthe release inteded for package maintainers. '

# The OCaml version to use for this pick (just the version number - options are elaborated in a platform dependent way)
COQ_PLATFORM_OCAML_VERSION='4.14.1'

###################### PACKAGE SELECTION #####################

PACKAGES=""

# - Comment out packages you do not want.
# - Packages which take a long time to build should be given last.
#   There is some evidence that they are built early then.
# - Versions ending with ~flex are identical to the opam package without the
#   ~flex extension, except that version restrictions have been relaxed.
# - The picking tracker issue is https://github.com/coq/platform/issues/193

########## BASE PACKAGES ##########

# Coq needs a patched ocamlfind to be relocatable by installers
PACKAGES="${PACKAGES} PIN.ocamlfind.1.9.5~relocatable"
# The Coq compiler coqc and the Coq standard library
PACKAGES="${PACKAGES} PIN.coq.8.17+rc1"
# Since dune does support Coq, it is explicitly selected
PACKAGES="${PACKAGES} dune.3.7.0"
PACKAGES="${PACKAGES} dune-configurator.3.7.0"

########## IDE PACKAGES ##########

# GTK based IDE for Coq - alternatives are VSCoq and Proofgeneral for Emacs
if  [[ "${COQ_PLATFORM_EXTENT}"  =~ ^[iIfFxX] ]]
then
PACKAGES="${PACKAGES} coqide.8.17+rc1"
fi

########## "FULL" COQ PLATFORM PACKAGES ##########

if  [[ "${COQ_PLATFORM_EXTENT}"  =~ ^[fFxX] ]]
then
  # Standard library extensions
  PACKAGES="${PACKAGES} coq-bignums.8.17.0"
  PACKAGES="${PACKAGES} coq-ext-lib.0.11.8"
  PACKAGES="${PACKAGES} coq-stdpp.1.8.0"

  # General mathematics
  PACKAGES="${PACKAGES} coq-mathcomp-ssreflect.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-fingroup.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-algebra.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-solvable.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-field.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-character.1.16.0"
  PACKAGES="${PACKAGES} coq-mathcomp-bigenough.1.0.1"
  PACKAGES="${PACKAGES} coq-mathcomp-finmap.1.5.2"
  PACKAGES="${PACKAGES} coq-mathcomp-real-closed.1.1.4"
  PACKAGES="${PACKAGES} coq-mathcomp-zify.1.3.0+1.12+8.13"
  PACKAGES="${PACKAGES} coq-mathcomp-multinomials.1.5.6"
  PACKAGES="${PACKAGES} coq-coquelicot.3.3.0"

  # Number theory
  PACKAGES="${PACKAGES} coq-coqprime.1.3.0"
  PACKAGES="${PACKAGES} coq-coqprime-generator.1.1.1"
  
  # Numerical mathematics
  PACKAGES="${PACKAGES} coq-flocq.4.1.1"
  PACKAGES="${PACKAGES} coq-interval.4.6.1"
  PACKAGES="${PACKAGES} coq-gappa.1.5.3"
  PACKAGES="${PACKAGES} gappa.1.4.1"

  # Constructive mathematics
  PACKAGES="${PACKAGES} coq-math-classes.8.17.0"
  PACKAGES="${PACKAGES} coq-corn.8.16.0"

  # Homotopy Type Theory (HoTT)
  PACKAGES="${PACKAGES} coq-hott.8.17"

  # Univalent Mathematics (UniMath)
  # Note: coq-unimath requires too much memory for 32 bit architectures
  if [ "${BITSIZE}" == "64" ]
  then
    case "$COQ_PLATFORM_UNIMATH" in
    [yY]) PACKAGES="${PACKAGES} coq-unimath.20230321" ;;
    [nN]) true ;;
    *) echo "Illegal value for COQ_PLATFORM_UNIMATH - aborting"; false ;;
    esac
  fi 

  # Code extraction
  PACKAGES="${PACKAGES} coq-simple-io.1.8.0"

  # Proof automation / generation / helpers
  PACKAGES="${PACKAGES} coq-menhirlib.20220210 menhir.20220210"
  PACKAGES="${PACKAGES} coq-equations.1.3+8.17"
  PACKAGES="${PACKAGES} coq-aac-tactics.8.17.0"
  PACKAGES="${PACKAGES} coq-unicoq.1.6+8.17"
  # PACKAGES="${PACKAGES} coq-mtac2.1.4+8.16" # needs patch
  PACKAGES="${PACKAGES} elpi.1.16.9 coq-elpi.1.17.1"
  # PACKAGES="${PACKAGES} coq-hierarchy-builder.1.4.0" # needs patch
  # PACKAGES="${PACKAGES} coq-quickchick.1.6.4" # needs patch
  # PACKAGES="${PACKAGES} coq-hammer-tactics.1.3.2+8.16" # needs patch
  if [[ "$OSTYPE" != cygwin ]]
  then
    # coq-hammer does not work on Windows because it heavily relies on fork
    # PACKAGES="${PACKAGES} coq-hammer.1.3.2+8.16"
    PACKAGES="${PACKAGES} eprover.2.6"
    PACKAGES="${PACKAGES} z3_tptp.4.11.2"
  fi
  PACKAGES="${PACKAGES} coq-paramcoq.1.1.3+coq8.17"
  PACKAGES="${PACKAGES} coq-coqeal.1.1.2"
  PACKAGES="${PACKAGES} coq-libhyps.2.0.6"
  PACKAGES="${PACKAGES} coq-itauto.8.17.0"
  
  # General mathematics (which requires one of the above tools)
  PACKAGES="${PACKAGES} coq-mathcomp-analysis.0.6.1" # dependency coq-matcomp-classical requires Coq version relaxation
  PACKAGES="${PACKAGES} coq-mathcomp-algebra-tactics.1.0.0"
  # PACKAGES="${PACKAGES} coq-relation-algebra.1.7.8" # fails to build after relaxation patching

  # Formal languages, compilers and code verification
  PACKAGES="${PACKAGES} coq-reglang.1.1.3" # requires Coq and mathcomp version relaxation
  PACKAGES="${PACKAGES} coq-iris.4.0.0"
  PACKAGES="${PACKAGES} coq-iris-heap-lang.4.0.0"
  PACKAGES="${PACKAGES} coq-ott.0.33"
  PACKAGES="${PACKAGES} ott.0.33"
  PACKAGES="${PACKAGES} coq-mathcomp-word.2.1"
  
  case "$COQ_PLATFORM_COMPCERT" in
    [yY]) PACKAGES="${PACKAGES} coq-compcert.3.12" ;;
    [nN]) true ;;
    *) echo "Illegal value for COQ_PLATFORM_COMPCERT - aborting"; false ;;
  esac

  case "$COQ_PLATFORM_VST" in
    [yY])
      # PACKAGES="${PACKAGES} coq-vst.2.11.1" # does not support CompCert 3.12
      true ;;
    [nN]) true ;;
    *) echo "Illegal value for COQ_PLATFORM_VST - aborting"; false ;;
  esac

  # # Proof analysis and other tools
  PACKAGES="${PACKAGES} coq-dpdgraph.1.0+8.16" # requires Coq version relaxation
fi

########## EXTENDED" COQ PLATFORM PACKAGES ##########

if  [[ "${COQ_PLATFORM_EXTENT}"  =~ ^[xX] ]]
then

  # Proof automation / generation / helpers
  PACKAGES="${PACKAGES} coq-deriving.0.1.1"
  # PACKAGES="${PACKAGES} coq-metacoq.1.1+8.16" # No 8.17 version

  # General mathematics
  PACKAGES="${PACKAGES} coq-extructures.0.3.1"

  # Gallina extensions
  PACKAGES="${PACKAGES} coq-reduction-effects.0.1.4"
  PACKAGES="${PACKAGES} coq-record-update.0.3.0"

  # Communication with coqtop
  PACKAGES="${PACKAGES} coq-serapi.8.17+rc1+0.17.1"

  # fiat crypto, bedrock2, rupicola and dependencies
  if [ "${BITSIZE}" == "64" ]
  then
    case "$COQ_PLATFORM_FIATCRYPTO" in
      [yY])
        PACKAGES="${PACKAGES} coq-coqutil.0.0.2"
        PACKAGES="${PACKAGES} coq-rewriter.0.0.7"
        PACKAGES="${PACKAGES} coq-riscv.0.0.3"
        PACKAGES="${PACKAGES} coq-bedrock2.0.0.4"
        PACKAGES="${PACKAGES} coq-bedrock2-compiler.0.0.4"
        PACKAGES="${PACKAGES} coq-rupicola.0.0.6"
        # PACKAGES="${PACKAGES} coq-fiat-crypto.0.0.17" # fails to build
        ;;
      [nN]) true ;;
      *) echo "Illegal value for COQ_PLATFORM_FIATCRYPTO - aborting"; false ;;
    esac
  fi
fi
