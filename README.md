![GitHub License](https://img.shields.io/github/license/llawn/scripts)
![GitHub repo size](https://img.shields.io/github/repo-size/llawn/scripts)
![GitHub Tag](https://img.shields.io/github/v/tag/llawn/scripts)
![GitHub top language](https://img.shields.io/github/languages/top/llawn/scripts)

# Scripts

My scripts for different os

|ID | PROGRAM                 |
|---|-------------------------|
|1  |extract-toml-structure.sh|

1. copy a toml file within the same repo and delete
all value but keep structure

```example.toml
[database]
host = "127.0.0.1"
port = 5432
username = "admin"
password = "secret"
```

```example_copy.toml
[database]
host = 
port =
username =
password =
```
