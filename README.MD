## Deno

A docker container for [deno](https://github.com/denoland/deno)

-----

Automatically runs with the group/user rights of the `/app` directory.
This requires that you mount your working directory in `/app`.

-----

The deno import cache is configured to point to the `.deno` directory in your working directory.

----

#### Run a thing

`docker run -it --rm -v $PWD:/app ruphin/deno thing.ts`

#### Run a remote thing

`docker run -it --rm -v $PWD:/app ruphin/deno https://deno.land/x/examples/example_test.ts`

#### Open a repl

`docker run -it --rm -v $PWD:/app ruphin/deno`

#### Open a shell

`docker run -it --rm -v $PWD:/app ruphin/deno bash`

### Preinstalled utilities

* deno
* wget
