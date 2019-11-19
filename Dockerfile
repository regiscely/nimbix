FROM nvidia/cuda-ppc64le:10.1-runtime-ubuntu18.04

COPY

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/regiscely/nimbix-image-common/master/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443

# repo
WORKDIR /tmp
ENV POWERAI_LINK https://public.dhe.ibm.com/software/server/POWER/Linux/mldl/ubuntu/mldl-repo-local_4.0.0_ppc64el.deb

#RUN curl -O "$POWERAI_LINK" && dpkg --install mldl*.deb && rm -f mldl*.deb

# install packages
#RUN apt-get update && apt-get -y upgrade && apt-get -y install power-mldl numactl && apt-get clean
COPY motd /etc/motd
COPY motd /etc/powerai_help.txt
COPY powerai_help.desktop /etc/skel/Desktop/powerai_help.desktop
RUN chmod 555 /etc/skel/Desktop/powerai_help.desktop
RUN echo '\n*** Press Q to exit help.\n' >>/etc/powerai_help.txt
