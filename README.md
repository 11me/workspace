# Workspace container
This is source `dockerfile` for creating my workspace container.
It pulls my dotfiles from github and setups the environment.

Check my [dotfiles](https://github.com/11me/dotfiles).

## Install
```
$ git clone https://github.com/11me/workspace

$ cd workspace

$ docker build --rm .
```

## Or pull from dockerhub
```
$ docker run -it 11me/workspace
```
