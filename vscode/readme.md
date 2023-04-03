generate with

```sh
$ code --list-extensions > extensions.txt
```

install all with

```sh
$ cat extensions.txt | xargs -n1 code --install-extension
```

