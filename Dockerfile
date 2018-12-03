FROM debian:9.6

### Create user and group ###
RUN addgroup app \
	&& useradd app --create-home -g app

RUN set -ex; \
	apt update; \
	apt install -yq ca-certificates wget; \
	rm -rf /var/lib/apt/lists/*;

### Install GOSU
ENV GOSU_VERSION 1.11
RUN set -ex; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -qO /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	chmod +x /usr/local/bin/gosu; \
	# verify that the binary works
	gosu nobody true;

### Install a bunch of standard libs and utilities that are required for building common nodejs modules
# RUN apt update \
# 	&& apt install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
# 	libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
# 	libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
# 	libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
# 	ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
# 	&& rm -rf /var/lib/apt/lists/*

ENV DENO_VERSION v0.2.1
RUN set -ex; \
	mkdir /deno; \
	wget -qO- "https://github.com/denoland/deno/releases/download/$DENO_VERSION/deno_linux_x64.gz" \
	| gunzip > /usr/local/bin/deno; \
	chmod +x /usr/local/bin/deno; \
	# Check if it worked
	deno -v;

ENV DENO_DIR /app/.deno

COPY bootstrap.sh /bootstrap.sh
COPY run.sh /home/app/run.sh
ENTRYPOINT ["/bootstrap.sh"]