---
title: "Code Review"
categories: [How To, Code Review]
tags: [trufflehog, code review]
weight: 2
draft: true
---

## Code Review

Here are some hopefully easily wins when looking at code. Start with some simple language agnostic things to check for.

### Secrets in code and git history

Trufflehog is an amazing tool that will find secrets based on patterns. If a discovered secret has a known way to validate it, Trufflehog will attempt to verify it.

Assume you have a repos checked out in a `domain.com/user/repo/`. We can scan all the repos with the following snippet.

```bash
for d in $(ls -d git??b.com/*/*); do trufflehog git file://`pwd`/$d --json | tee truffle-$(echo $d | sed 's|/|-|g').json; done 
```

We can count how many Potential secrets we have by running:

```bash
cat truffle*.json | jq '.Raw' | sort -u | wc -l
```


We can count how many verified secrets we have by running:

```bash
cat truffle*.json | jq 'select(.Verified == true) | .Raw' | sort -u | wc -l  
```

Lets inspect valid ones:

```bash
cat truffle*.json | jq 'select(.Verified == true)' --color-output | less 
```

### SQL Statements

```bash
base_query_ent_regex="[^;]{0,300}"
update_regex="update\s+$base_query_ent_regex\s+set\s+$base_query_ent_regex\s+where\s+"
insert_regex="insert\s+into\s+$base_query_ent_regex\s+(set.+?=]|values\s+(\(|select))\s+"
delete_regex="delete\s+from\s+$base_query_ent_regex\s+where\s+"
select_regex="select\s+$base_query_ent_regex\s+from\s+$base_query_ent_regex\s+where\s+"

query_regex="\s*($update_regex|$insert_regex|$delete_regex|$select_regex)"

big_regex="(\"\"\"$query_regex[^;]+?\"\"\"|\`$query_regex[^\`]+\`|\"$query_regex[^\"]+\"|'$query_regex[^']+')"

ag $COLOR --ignore '.*\.json' $big_regex
```

### Semgrep

```bash
for d in $(ls -d git??b.com/*/*); do semgrep scan `pwd`/$d --json | tee semgrep-$(echo $d | sed 's|/|-|g').json; done
```