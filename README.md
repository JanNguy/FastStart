
# ⚡️ FastStart

FastStart is a C project starter programmed in bash.

## Options

-h or --help : Displays help and available options.

-g : Initializes a Git repository in the current directory.

-b <name> : Creates and checks out a new Git branch with the specified name.

-m <message> : Specifies the Git commit message.

-p : Pushes changes to the remote repository.

--arg : Adds argument handling to the main function.

--h : Adds a header file.

--makef : Creates a Makefile.

## Demo

![](https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcmp0NzVsenc5d2o2YjA3anBseW00bHoyNHRsemZkdXh5NzUwYmdkcCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/WyyzzezzXL6geZfe5X/giphy.gif)
## Start up

### Mac

Due to apple security we have to use /opt/local/ instead of /opt.

```bash
    cd ~
    git clone git@github.com:JanNguy/FastStart.git
    sudo mkdir /opt/fastStart
    sudo mv FastStart/* /opt/fastStart
    sudo ln -sf /opt/fastStart/fast /usr/local/bin/fast
    sudo chmod +x /opt/fastStart/fast
```
You should have something like this:
```bash
    ls -l /usr/local/bin/fast
```

```output
   lrwxr-xr-x  1 root  wheel  19 19 jui 00:07 /usr/local/bin/fast -> /opt/fastStart/fast
```

### Linux

```bash
cd ~
git clone git@github.com:JanNguy/FastStart.git
sudo mkdir -p /opt/fastStart
sudo mv FastStart/* /opt/fastStart
sudo ln -sf /opt/fastStart/fast /usr/local/bin/fast
sudo chmod +x /opt/fastStart/fast
```
You should have something like this:
```bash
ls -l /usr/local/bin/fast
```

```output
lrwxr-xr-x  1 root  root  19 jui 19 00:07 /usr/local/bin/fast -> /opt/fastStart/fast
```



