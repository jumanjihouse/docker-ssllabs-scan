Contributing
============

Please follow [Github Flow](https://guides.github.com/introduction/flow/index.html).

This is a rough outline of the workflow:

* Create a topic branch from where you want to base your work. This is usually master.
* Make commits of logical units.
* Make sure your commit messages are in the proper format (see below).
* Push your changes to a topic branch in your fork of the repository.
* Submit a pull request.
* Rebase and force-push to your fork's branch as necessary.

Thanks for you contributions!


Commit message
--------------

We follow a rough convention for commit messages borrowed from Angularjs. This
is an example of a commit:

    add a cluster test command

    this uses tmux to setup a test cluster that you can easily kill and
    start for debugging.

To make it more formal it looks something like this:

    <subject>
    <BLANK LINE>
    <body>
    <BLANK LINE>
    <footer>

The first line is the subject and should not be longer than 70 characters, the
second line is always blank and other lines should be wrapped at 80 characters.
This allows the message to be easier to read on github as well as in various
git tools.

* The **subject** line contains succinct description of the change.
  - use imperative, present tense: **change**, not *changed* nor *changes*
  - don't capitalize first letter
  - no dot (.) at the end
  - max 70 chars

* The **body** describes *why* the change is necessary.
  - like `<subject>`, use imperative, present tense
  - include motivation for the change and contrasts with previous behavior
  - wrap lines at 72 chars when possible


More details on commits
-----------------------

For more details see the [angularjs commit style guide]
(https://docs.google.com/a/coreos.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit#).
