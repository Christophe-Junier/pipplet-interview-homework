## Getting started with Docker

1. Ensure that the docker daemon is running, then build the image.
```
$ docker build -t pipplet-interview .
```

2. Start rails in dev mode
```
$ docker run --rm -it -v $(pwd):/pipplet -p 3000:3000 pipplet-interview
```

3. Connect to the container, to run commands for example:
```
$ docker run --rm -it -v $(pwd):/pipplet -p 3000:3000 pipplet-interview bash
```