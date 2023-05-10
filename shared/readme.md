## shared


### vscode


generate with

```sh
$ code --list-extensions > vscode/extensions.txt
```

install all with

```sh
$ cat vscode/extensions.txt | xargs -n1 code --install-extension
```
