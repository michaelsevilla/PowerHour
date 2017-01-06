# PowerHour

This software automatically plays videos off YouTube and kills them after 60
seconds. 

# Quickstart

1. Add YouTube link to `videos.txt`

2. Run the program with `./run.sh`

# Formatting video links

Videos must be formatted as follows:

1. Go to video on YouTube, click "share", click "embed"

2. Grab the "src" value; for example, the embedded link:

    ```
    <iframe width="560" height="315"
    src="https://www.youtube.com/embed/h95aCC_7XwI" frameborder="0"
    allowfullscreen></iframe>
    ```

    has a source value of:

    ```
    https://www.youtube.com/embed/h95aCC_7XwI
    ```

3. Add a start time by appending `?start=20&autoplay=1`

The final value looks like this:

```bash
https://www.youtube.com/embed/h95aCC_7XwI?start=20&autoplay=1
```

# Compatability

Tested on a Mac; GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin14)
