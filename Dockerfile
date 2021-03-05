FROM rclone/rclone:latest as rclone
RUN /usr/local/bin/rclone --version

FROM linuxserver/nzbget:latest
COPY --from=rclone /usr/local/bin/rclone /usr/local/bin/rclone

RUN apk update
RUN apk add --virtual build-deps file make gcc musl-dev libffi-dev python2 python2-dev py2-setuptools libc-dev g++
#RUN apk add --no-cache --upgrade --virtual=build-dependencies \
#    python2-dev \
#    python2 \
#    py2-setuptools
RUN easy_install-2.7 https://files.pythonhosted.org/packages/54/eb/4a3642e971f404d69d4f6fa3885559d67562801b99d7592487f1ecc4e017/pip-20.3.3-py2.py3-none-any.whl#sha256=fab098c8a1758295dd9f57413c199f23571e8fde6cc39c22c78c961b4ac6286d
RUN pip install wheel
RUN pip install gevent

# ports and volumes
VOLUME /config
EXPOSE 6789

