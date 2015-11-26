FROM ubuntu:14.04

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN apt-get update && apt-get install -y \
    openssh-server \
  \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  \
  && ssh-keygen -q -b 1024 -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key \
  && ssh-keygen -q -b 1024 -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key \
  && ssh-keygen -q -b 521 -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
  \
  && sed -i -r 's/.?UseDNS\syes/UseDNS no/' /etc/ssh/sshd_config \
  && sed -i -r 's/.?PasswordAuthentication.+/PasswordAuthentication no/' /etc/ssh/sshd_config \
  && sed -i -r 's/.?UsePAM.+/UsePAM no/' /etc/ssh/sshd_config \
  && sed -i -r 's/.?ChallengeResponseAuthentication.+/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config \
  && sed -i -r 's/.?PermitRootLogin.+/PermitRootLogin yes/' /etc/ssh/sshd_config

COPY container-files /

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
