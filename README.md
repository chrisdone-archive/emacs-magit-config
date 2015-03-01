# emacs-magit-config

A quick and easy pre-configured Emacs for using magit.

### License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

## Prerequisites

It's easier if you're running Linux or OS X. If you're on Windows,
there is no guarantee whether anything described will work.

## Download

Run the following to clone this repo and its dependencies:

    $ git clone https://github.com/chrisdone/emacs-magit-config.git --recursive

That shouldn't take a minute.

## Running

In the repo directory, run this:

    $ emacs -Q -l init.el

The `-Q` is short for "quick" and means it will not use any existing
Emacs configuration that you already have.

The `-l init.el` will load this repo's init configuration.

If you decide you want to use this configuration as-is or as a base,
you can put the following in your `~/.emacs` file:

    (load "/path/to/emacs-magit-config/init.el")

Then run Emacs from the terminal as simply:

    $ emacs

## Using

Run `emacs` in the given directory:

    $ emacs

And it will automatically run the equivalent of typing `M-x
magit-status RET` in Emacs.

magit commands themselves can be accessed via `?` that lists the
regular commands, hitting a further key of those listed (e.g. `c`)
shows more help for that command. Ctrl-g cancels any popup of any kind
in Emacs.

## Common keybindings

* `g` - refresh the buffer
* `l` - log (`n`/`p` inside the log also does the expected thing)
* `q` - close a buffer (e.g. the log)
* `n`/`p` - move to next/prev hunk/section
* `TAB` - expand a changeset
* `s` - stage a hunk. You can select parts of a hunk to stage just
  that part.
* `u` - unstage the thing the cursor is on. Again, you can select what
  to unstage if necessary.
* `-` / `+` - increase/decrease hunk granularity.
* `k` - kill/delete a hunk.
* `c` - commit
* `C-c C-c` - inside
* `b` - checkout a branch or a specific commit
* `s` - stash the current working changeset
* `F` - pull from the remote
* `F - r F` - pull --rebase
* `P` - push

Regular Emacs commands:

* `Ctrl-x k` - kill the current buffer
* `Ctrl-g` - cancel whatever prompt is prompting you
