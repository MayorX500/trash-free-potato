
# Visual Paradigm Dockerized

Run Visual Paradigm from a Docker Container.

I try to run a clean system, and Visual Paradigm did not fit that idea. Somehow, a sketchy installer consisting of a +2 million line, +600 MB shell script where most of the content can't be reviewed is “OK” to some people, but not for me.

So I set out to run Visual Paradigm from a Docker container. It's not been heavily used by myself just yet, so your mileage may vary. I took inspiration from [@jurgen.verhasselt](https://gitlab.com/jurgen.verhasselt) [Docker Implementation](https://gitlab.com/sjugge/docker/visual-paradigm) and expanded it for my needs.


## Installation

How to install Visual Paradigm.

Visual Paradigm Dockerized requires [Docker](https://www.docker.com/), [Devour](https://github.com/salman-abedin/devour) and [Make](https://www.gnu.org/software/make/). It also requires the user to be a part of the `docker` group.

Devour is installed during the first installation using `git clone`.


Clone the project

```bash
  git clone https://github.com/MayorX500/trash-free-potato
```

Go to the project directory

```bash
  cd trash-free-potato
```

Install the dependencies, copy the file `env.example` and rename it to `.env`.
Edit the new `.env` file accordingly as the installer uses it for the installation.

```bash
  cp env.example .env
  vim .env
```

After editing the `.env` file, just run the Makefile.

```bash
  make
```

The installer asks if the Container should be installed in a `local` or `global` way. `⚠ Do you wish to install for all USERS? [y/n]`. Answering `N` will install the launch script and `.desktop` file in the `$USER` home directory under `.local`. Answering `Y` will place the same files in the `/usr` directory, allowing it to be accessed by all users.
## Running

Running VPDocker

This container comes with a `.desktop` file and a `bash` executable to be able to start Visual Paradigm. Both file names are editable in the `.env` file.

If you wish to open a shell in the container.
```bash
docker exec -it vp-container bash
```

#### Linux

Local data from the host system is shared with the container by mounting a “share” directory configurable in the `.env` file under the `APP_SHARED_DIR` field.

#### X Applications

Note that you may need to run `xhost local:docker` to grant docker access to X server.

Some `wm`'s cannot load a java GUI, as a workaround follow this [link](https://wiki.archlinux.org/title/java#Impersonate_another_window_manager).

```bash
wmname LG3D
```


## Disclaimer

VPDocker Disclaimer

This is served “as is” and hasn't been tested in either `macOS` or `Windows`, the only OS used is `Arch Linux 6.5.5` as of 28 Sep 2023.

My currently running machines.
|Status| OS and Kernel             | Visual Paradigm Version | Docker Version|
|-|-|-|-|
|![#0a192f](https://via.placeholder.com/10/32a846?text=+) Running| Linux 6.5.5-arch1-1 | Visual Paradigm Standard 17.0 | Docker version 24.0.5|

## Known Issues

Issues found with the Dockerized approach.

- Slow download of the installer. There seem to be various locations from where the VP install script will be downloaded, some slower than others. If progress is too slow, abort the installation, remove the container and re-run. Chances are good you'll receive the VP install scripts from another, faster server.



## Acknowledgements

* [@jurgen.verhasselt's Visual Paradigm Docker implementation](https://gitlab.com/sjugge/docker/visual-paradigm)
* [@pkoper's GNU make utilities (KISS)](https://github.com/pkoper/mk)
* [Visual Paradigm legal info](https://www.visual-paradigm.com/aboutus/legal.jsp).


