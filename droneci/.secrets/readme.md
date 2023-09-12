# Decrepiting files

## Age

All sensitive files are encrypted via age cli. Below is the CLI to decrypt all files at once.

#### Decrypting

```(shell)
for s in $(find * -type f -print); do age -d -i ~/.ssh/id_rsa -o $(ls $s | awk -F '.' '{ print $1}')\.env $s ; done
```

#### Encypting

```(shell)
WIP
```
