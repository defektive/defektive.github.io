+++
title = "Target Acquisition: Git"
weight = 32
+++

Lets go to github and see what we can find. Open https://github.com/snakshare.

```bash
mkdir -p ~/Desktop/op/code/github.com/snakshare
cd ~/Desktop/op/code/github.com/snakshare
git clone https://github.com/SnakShare/snakshare.github.io.git
```

Now we can get a list of users and email addresses.

```bash
git log --pretty="format:%aN, %ae%n%cN, %ce" | sort -u | tee ~/Desktop/op/git-users.csv
```