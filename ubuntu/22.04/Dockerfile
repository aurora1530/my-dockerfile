FROM ubuntu:22.04

# Set the locale to Japanese and timezone to Tokyo
RUN apt-get update && \
    apt-get install -y locales tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.utf8
ENV TZ=Asia/Tokyo

WORKDIR /workdir