#
# Copyright 2015-2017 ZomboDB, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:precise

MAINTAINER ZomboDB, LLC (zombodb@gmail.com)

# get locale set to UTF-8
RUN locale-gen en_US.UTF-8
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# turn off warnings from debconf
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# ask apt to update itself
RUN apt-get update -y -qq --fix-missing

# update apt
RUN apt-get update -y -qq
RUN apt-get install -y -qq apt-utils

# must have wget
RUN apt-get install -y -qq wget

# elasticsearch
RUN echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-1.7.list
RUN wget --no-check-certificate -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -

# postgres
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN wget --no-check-certificate -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# java 7
RUN apt-get install -y -qq python-software-properties
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -y -qq && \
  apt-get install -y -qq oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# misc
RUN apt-get update -y -qq
RUN apt-get install -y -qq sudo
RUN apt-get install -y -qq gnupg
RUN apt-get install -y -qq build-essential
RUN apt-get install -y -qq libz-dev

# maven
RUN apt-get install -y -qq maven

# stack
RUN apt-get install -y -qq elasticsearch
RUN apt-get install -y -qq postgresql-9.5 postgresql-server-dev-9.5

# custom libcurl req'd by ZomboDB to statically link against
COPY config/curl-7.43.0.tar.gz /tmp/
RUN cd /tmp/ && tar xzf /tmp/curl-7.43.0.tar.gz
RUN cd /tmp/curl-7.43.0 && ./configure --without-librtmp --disable-ares --disable-threaded-resolver --disable-dict --disable-file --disable-ftp --disable-gopher --disable-imap --disable-pop3 --disable-rtsp --disable-smb --disable-smtp --disable-telnet --disable-tftp
RUN cd /tmp/curl-7.43.0 && make -j2 && make install
RUN ldconfig && ldconfig
RUN rm -rf /tmp/curl-7.43.0*

# bootstrap maven repo
COPY config/maven-repo.tgz /tmp/
RUN tar xzf /tmp/maven-repo.tgz
RUN rm /tmp/maven-repo.tgz

# install pg_prove
RUN PATH="/root/perl5/bin${PATH:+:${PATH}}"; export PATH; \
PERL5LIB="/root/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB; \
PERL_LOCAL_LIB_ROOT="/root/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT; \
PERL_MB_OPT="--install_base \"/root/perl5\""; export PERL_MB_OPT; \
PERL_MM_OPT="INSTALL_BASE=/root/perl5"; export PERL_MM_OPT; \
cpan TAP::Parser::SourceHandler::pgTAP

# install pg_tap
RUN apt-get install -y git
RUN git clone https://github.com/theory/pgtap.git
RUN cd pgtap && make && make install

# setup runtime env
RUN mkdir /build/
RUN mkdir /build/zombodb
COPY config/build.sh /build/
RUN chmod a+x /build/build.sh

ARG user
ARG uid
RUN useradd -ms /bin/bash --uid $uid $user
ENV HOST_USER $user
WORKDIR /build/zombodb
ENTRYPOINT ["/build/build.sh"]
CMD ["/bin/bash"]
