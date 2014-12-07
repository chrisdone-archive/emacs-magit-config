# emacs-haskell-config

A quick and easy pre-configured Emacs for developing with Haskell

Dependencies are included or explicitly stated.

## Prerequisites

It's easier if you're running Linux or OS X. If you're on Windows,
there is no guarantee whether anything described will work.

You need GHC version GHC 7.8.2—7.8.3. Check that with:

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

Install haskell-docs:

    $ cabal install packages/haskell-docs/

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

## Using

You need a Cabal project, `cabal repl` does not work without one. If
you do not have a `.cabal` file, just make a dummy one.

For convenience I made a sandbox for random Haskell playing:

    $ git clone https://github.com/chrisdone/haskell-sandbox.git

Open up `src/Main.hs`. Run `C-c C-l` to bring up the REPL and start a
session. It'll prompt with something like:

> Start a new project named “haskell-sandbox” (y or n)

Hit `y`. It will guess the directory of your project based on the
`.cabal` file, hit RET on that. It'll prompt for the current
directory, hit RET on that too. In a second you should see a REPL
window like:

    Your wish is my IO ().
    If I break, you can:
      1. Restart:           M-x haskell-process-restart
      2. Configure logging: C-h v haskell-process-log (useful for debugging)
      3. General config:    M-x customize-mode
      4. Hide these tips:   C-h v haskell-process-show-debug-tips

Now you can start hacking. Paste something like this into `Main.hs`:

``` haskell
fib :: Integer -> Integer
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)
```

## Structured editing

There's a fairly complete list of commands for structured editing
[here](https://github.com/chrisdone/structured-haskell-mode/#features).

The basic gist is that your source is parsed whenever you are idle for
half a second and then you have a "current node". That node is
indicated by the background color. You can expand it with `M-a` or `)`
depending on the direction you want to go. Normal Emacs commands are a
bit smarter than usually, specifically `C-k`, `C-w`, `C-y`, `C-j`
which all pay attention to the AST and often your current selection.

Don't use `TAB` for indentation, use the structured selection and use
`C-j` which will make a newline and indent to the right location.

Don't do manual formatting. See next section.

## Pretty printing

To format a Haskell declaration, run `C-c i`. Running it on the third
`fib` declaration should yield:

``` haskell
fib n =
  fib (n - 1) +
  fib (n - 2)
```

## Type checking

To type check and load the current module, run `C-c C-l`, or simply
`F5`. If everything is OK it'll say `OK` in the minibuffer at the
bottom.

If you create a type error, by e.g. removing the `(n-2)` in the code
sample above, you'll see the following in the minibuffer:

    src/Main.hs:8:21-23: Couldn't match expected type ‘Integer’ [ with actua .. ]

In the REPL window you'll see the full error:

    src/Main.hs:8:21-23: Couldn't match expected type ‘Integer’ …
                    with actual type ‘Integer -> Integer’
        Probable cause: ‘fib’ is applied to too few arguments
        In the second argument of ‘(+)’, namely ‘fib’
        In the expression: fib (n - 1) + fib
    Compilation failed.

You can run <code>C-x \`</code> to jump to the error
line/column. Correct the error and hit `F5` and you should get `OK`
again.

## Type information

Once you've loaded your module in, you can go to any identifier and
run `C-c C-t`. E.g. if you go to `n` and run `C-c C-t` you'll see this
in the minibuffer:

``` haskell
n :: Integer
```

If you select the `n - 1` and hit `C-c C-t` you'll see this:

``` haskell
n - 1 :: Integer
```

## Go to definition

If you go to the `n` in `n - 2` and run `M-.` it will jump to the `n`
in `fib n`.

## Highlight uses

If you go to the `n` in `n - 2` and run `C-?` it will highlight all
the occurrences. You can hit `TAB` to go forwards in the results, or
`S-TAB` to go backwards. Hit `RET` to stop where you are, or `C-g` to
stop and go back to where you were originally.

## Interactive REPL

The REPL is pretty self-explanatory. Write expressions and hit `RET`
to see the results:

``` haskell
λ> import Data.List
λ> sort [5,2,3,5,22]

<interactive>:43:1-17: Warning:
    Defaulting the following constraint(s) to type ‘Integer’
      (Show a0) arising from a use of ‘print’ at <interactive>:43:1-17
      (Ord a0) arising from a use of ‘it’ at <interactive>:43:1-17
      (Num a0) arising from a use of ‘it’ at <interactive>:43:1-17
    In a stmt of an interactive GHCi command: print it
[2,3,5,5,22]
λ> :t sort [5,2,3,5,22]
sort [5,2,3,5,22] :: (Ord a, Num a) => [a]
```

The results are syntax coloured automatically.

If there is ever a problem with the REPL, you can just hit `C-c C-k`
to clear it, or `M-x haskell-process-restart` to restart the whole
thing.

## Cabal actions

To build with Cabal run `C-c C-c`. This will run `cabal build` on the
project and interpret any compile errors/warnings as it does when you
run `C-c C-l` or `F5`.

In our sandbox project, you should get something like:

    Compiling: Main
    src/Main.hs:1:1: The IO action ‘main’ is not defined in module ‘Main’
    Complete: cabal build (1 compiler messages)

So you can just add something like:

    main = print (fib 10)

And save the buffer and then run `C-c C-c` again. You should get
output like:

    Compiling: Main
    Linking: dist/build/haskell-sandbox/haskell-sandbox
    src/Main.hs:12:1: Warning: …
        Top-level binding with no type signature: main :: IO ()
    Complete: cabal build (2 compiler messages)

A typical issue. Check the next section for handling this nicely.

You can also run `C-c c` and you will get a prompt of cabal
commands. From here you can run `cabal bench`, `cabal test`, `cabal
haddock`, `cabal install`, etc.

## Inserting types

If we've loaded the Main module, then we can correct that missing
signature by going to the `main` identifier and running `C-u C-c
C-t`. This is like normal `C-c C-t`, except it will insert the type
for you. You should now have:

``` haskell
main :: IO ()
main = print (fib 10)
```

And running `F5` again should yield no warnings.

## Information about types

If you put your cursor on `IO` and hit `C-c C-i`, you will get GHCi's
`:i` information about that in a popup, like this:

``` haskell
-- Hit `q' to close this window.

newtype IO a
  = ghc-prim:GHC.Types.IO (ghc-prim:GHC.Prim.State#
                             ghc-prim:GHC.Prim.RealWorld
                           -> (# ghc-prim:GHC.Prim.State# ghc-prim:GHC.Prim.RealWorld, a #))
  	-- Defined in ‘ghc-prim:GHC.Types’
instance Monad IO -- Defined in ‘GHC.Base’
instance Functor IO -- Defined in ‘GHC.Base’
```

You can drill down further in that buffer again with `C-c C-i` e.g. on
`Monad`:

``` haskell
-- Hit `q' to close this window.

class Monad (m :: * -> *) where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
  fail :: String -> m a
  	-- Defined in ‘GHC.Base’
instance Monad (Either e) -- Defined in ‘Data.Either’
instance Monad Maybe -- Defined in ‘Data.Maybe’
instance Monad [] -- Defined in ‘GHC.Base’
instance Monad IO -- Defined in ‘GHC.Base’
instance Monad ((->) r) -- Defined in ‘GHC.Base’
```

And again `C-c C-i` on `Maybe`:

``` haskell
-- Hit `q' to close this window.

data Maybe a = Nothing | Just a 	-- Defined in ‘Data.Maybe’
instance Eq a => Eq (Maybe a) -- Defined in ‘Data.Maybe’
instance Monad Maybe -- Defined in ‘Data.Maybe’
instance Functor Maybe -- Defined in ‘Data.Maybe’
instance Ord a => Ord (Maybe a) -- Defined in ‘Data.Maybe’
instance Read a => Read (Maybe a) -- Defined in ‘GHC.Read’
instance Show a => Show (Maybe a) -- Defined in ‘GHC.Show’
```

Once you're done, you can hit `q` on each of the windows to get rid of
them. There will be a log of the output in your REPL, which you can
refer to later.

## Import completion

If you type `import` and hit `SPC` you will get a module
completion. Type `d.b.l` and hit `RET` and you should get
`Data.ByteString.Lazy`. Do another import of `c.m.re` and you should
have:

``` haskell
import Control.Monad.Reader
import Data.ByteString.Lazy
```

The new imports will be auto-sorted. If you want to qualify the second
line, go to it and run `C-c C-q`. Once you're done you can run `C-c
C-.` to sort and indent the imports.

Hit `F5` to check that your imports were good. You should see an error
in the bottom like this:

    src/Main.hs:5:18-37: Could not find module ‘Control.Monad.Reader’ …
        It is a member of the hidden package ‘mtl-2.1.3.1’.
        Perhaps you need to add ‘mtl’ to the build-depends in your .cabal file.
        It is a member of the hidden package ‘monads-tf-0.1.0.2’.
        Perhaps you need to add ‘monads-tf’ to the build-depends in your .cabal file.
        Use -v to see a list of the files searched for.

And a prompt like this:

> Add `mtl` to haskell-sandbox.cabal? (y or n)

See the next section.

## Dependency adding

With this prompt,

> Add `mtl` to haskell-sandbox.cabal? (y or n)

hit `y`. It will give you the opportunity to adjust the version constraints. Just
hit `RET`. It will prompt whether to add it to the executable
section. Hit `y`. Finally, it asks whether to save the file, hit `y`.

You'll now be prompted with the same process for `bytestring`. If you
don't want to do it, hit `C-g` at any point. But in this case we want
to do it. Repeat the same process for bytestring.

Now go back to `Main.hs` and run `F5`, it will say "Cabal file
changed; restart GHCi process? (y or n)" Hit `y`.

It will restart the process and compile `Main.hs`. See the next
section for the next prompt.

## Redundant imports

If you followed the previous step, you should have a redundant import
for `Control.Monad.Reader`. It will prompt whether to remove it. Let's
remove it for now, but we'll automatically add it back later. Hit `y`
on all the redundant import prompts.

## Automatically adding imports

Add the following function to `Main.hs`:

``` haskell
test = runReader (return ()) ()
```

And hit `F5`. It should say:

> Identifier `runReader` not in scope, choose module to import? (y or
> n)

Hit `y` and choose `Control.Monad.Reader`. Now you can run `F5` and it
should be a successful compile.
