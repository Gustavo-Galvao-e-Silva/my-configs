# Configs

## The what:

This repo contains my minimal setup for programming using Vim (the GOAT editor) and OhMyZsh, which are my main forms of text/code-editing for the languages I usually work with (Python and Java), along with JSON config files for VSCode for other languages and forms of editing, such as Jupyter Notebooks and JavaScript.

## The why:

To make my life easier, I decided to keep a copy of my setup in GitHub in case I ever need to work on a new machine, making set up way easier.

## Setting up Vim and OhMyZsh:

After installing Vim and OhMyZsh, copy each file content into their respective counterparts in you local machine.

When done with Vim by copying the `.vimrc` file, run inside the Vim command line:

```bash
:PlugInstall
```

After all plugins are installed, add any Coc extensions with the Vim command:

```bash
:CocInstall EXTENSION-NAME
```

## Setting up VSCode:

If VSCode is, for some reason, required (bummer I know :P), first install the Vim extension in the VSCode extensions marketplace.

Then, create a file named `.vscvimrc` and copy all contents from the updated `.vimrc` file into it.

Inside VSCode, copy the JSON config file into the `settings.json` file and saving. Lastly, restart VSCode to have Vim-motions and all new binds and appearance working.
