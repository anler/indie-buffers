# indie-buffers

The goal of this package is to allow you to focus in certain parts of your code by exploiting various Emacs' functionalities such as indirect buffers and narrowing. The idea is that instead of working in a big buffer, you create *lense buffers* to each relevant parts of the code.

There is currently just one main functionality: create an indie buffer from a region. With a couple of variations: create the buffer in other window or in other frame.

## Installation

I highly recommend installing through `package.el`.

It's available on [MELPA](http://melpa.org/) and [MELPA Stable](http://stable.melpa.org):

    M-x package-install indie-buffers

## Basic usage

Start out with:

    (require 'indie-buffers)

Then you have to set up your keybindings - indie-buffers doesn't presume to
know how you'd like them laid out. Here are some examples:

When you have an active region that spans multiple lines, the following will
create an indie buffer for that region:

    (global-set-key (kbd "C-c i r") 'indie-buffers-region)

Similarly you can create the buffer in another window or frame:

    (global-set-key (kbd "C-c i o") 'indie-buffers-region-other-window)
    (global-set-key (kbd "C-c i f") 'indie-buffers-region-other-frame)

## Current TODO list

- [ ] Command for narrowing *defun*s instead of regions.
- [ ] Command for narrowing imenu definitions.
- [ ] Correctly handle indentation in indirect buffers.
- [ ] Command to easily navigate the indirect buffers of a main buffer.

## Contribute

Yes, please do. There's a primitive suite of tests, so remember to add tests for your
specific feature, or I might break it later.

You'll find the repo at:

    https://github.com/anler/indie-buffers

To fetch the test dependencies, install
[cask](https://github.com/rejeep/cask.el) if you haven't already,
then:

    $ cd /path/to/indie-buffers
    $ cask

Run the tests with:

    $ cask exec ert-runner

## License

See `LICENSE` file.
