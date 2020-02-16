FROM debian:10
ARG USERNAME
ARG PASSWORD
RUN set -x; \
    apt-get update; \
    apt-get install -y --no-install-recommends openssh-server; \
    useradd -m -d /home/$USERNAME -c "$USERNAME" -u 1033 -s /bin/bash $USERNAME; \
    echo "$USERNAME:$PASSWORD" | chpasswd; \
    rm -rf /var/lib/apt/lists/*;
COPY --chown=$USERNAME:$USERNAME $USERNAME.pem.pub /home/$USERNAME/.ssh/authorized_keys
COPY sshd_config /etc/ssh/
RUN set -x;\
    chmod 400 /home/$USERNAME/.ssh/authorized_keys
EXPOSE 22
VOLUME ["/data"]
RUN ln -s /data/ /home/$USERNAME/$USERNAME_data
CMD ["/etc/init.d/ssh", "start", "-D"]
