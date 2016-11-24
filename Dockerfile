FROM debian
MAINTAINER Jacques Grelet "Jacques.Grelet@ird.fr"
RUN apt-get update && apt-get -y install \ 
	make \
	cmake \
	netcdf-bin \
	libnetcdf-dev \ 
	libxml2 \
	libxml2-dev \
	exfat-fuse \
	exfat-utils \
	vim \
	subversion \
	net-tools \
	iputils-ping \
	libxml-libxml-perl \
	libswitch-perl \ 
	libpdl-netcdf-perl \
	libdate-manip-perl \
	libconfig-tiny-perl \ 
	&& rm -rf /var/lib/apt/lists/*
# install perl Oceano modules from subversion
RUN mkdir -p /usr/local/src/perl-modules
WORKDIR /usr/local/src/perl-modules
#RUN svn co https://svn.mpl.ird.fr/us191/oceano/trunk/lib/perl/Oceano/
COPY Oceano-0.02.tar.gz .
RUN tar zxf Oceano-0.02.tar.gz
RUN cd Oceano-0.02 && perl Makefile.PL && make && make install
VOLUME /data
RUN groupadd -r scientifiques && useradd -r -g scientifiques -p antea science 
USER science
WORKDIR /home/science
ENV CRUISE LAPEROUSE
ENV DRIVE /data/campagnes
#COPY .bashrc /root
COPY .bashrc /home/science
