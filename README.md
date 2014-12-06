# emacs-haskell-config

A quick and easy pre-configured Emacs for developing with Haskell

Dependencies are included or explicitly stated.

## Prerequisites

It's easier if you're running Linux or OS X. If you're on Windows,
there is no guarantee whether anything described will work.

You need GHC version GHC 7.8.3—7.8.3. Check that with:

    $ ghc --version
    The Glorious Glasgow Haskell Compilation System, version 7.8.2

You need `cabal` installed. It shouldn't be particularly important
which version you have as long as it isn't ancient.

    $ cabal --version
    cabal-install version 1.20.0.3
    using version 1.20.0.2 of the Cabal library

Make sure your `~/.cabal/bin` is in your `PATH`.

## Download

Run the following to clone this repo and its dependencies:

    $ git clone https://github.com/chrisdone/emacs-haskell-config.git --recursive

That should take about a minute or two.

## Install

Install structured-haskell-mode:

    $ cabal install packages/structured-haskell-mode/

Install ghci-ng:

    $ cabal install packages/ghci-ng/

Install hindent:

    $ cabal install packages/hindent/

## Build

Build the haskell-mode Elisp:

    $ cd packages/haskell-mode/
    $ make

Build the structured-haskell-mode Elisp:

    $ cd packages/structured-haskell-mode/elisp/
    $ make

## Running

In the repo directory, run this:

    $ emacs -Q -l init.el

The `-Q` is short for "quick" and means it will not use any existing
Emacs configuration that you already have.

The `-l init.el` will load this repo's init configuration.

If you decide you want to use this configuration as-is or as a base,
you can put the following in your `~/.emacs` file:

    (load "/path/to/emacs-haskell-config/init.el")

Then run Emacs from the terminal as simply:

    $ emacs & disown

You need to run it from the terminal to ensure that your `PATH` is
configured, otherwise it's more difficult to setup.
