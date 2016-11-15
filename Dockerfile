FROM debian
#FROM perl:5.24.0
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
	libxml-libxml-perl \
	libswitch-perl \ 
	libpdl-netcdf-perl \
	libdate-manip-perl \
	libconfig-tiny-perl
# install perl Oceano modules from subversion
RUN mkdir -p /usr/local/src/perl-modules
WORKDIR /usr/local/src/perl-modules
RUN svn co https://svn.mpl.ird.fr/us191/oceano/trunk/lib/perl/Oceano/
RUN cd Oceano && perl Makefile.PL && make && make install
VOLUME /data
RUN groupadd -r scientifiques && useradd -r -g scientifiques science 
USER science
WORKDIR /home/science
ENV CRUISE LAPEROUSE
ENV DRIVE /data/campagnes
#COPY .bashrc /root
COPY .bashrc /home/science
