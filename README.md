# bash-progress-wheel

Bash progress wheel which can be printed while a command is running in the background. For example:

```bash
sleep 5 & pid=$!
utils::print_progress $pid "Sleeping" 
```

