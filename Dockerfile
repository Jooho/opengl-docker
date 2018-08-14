#FROM registry.centos.org/centos/centos
FROM centos:centos6
MAINTAINER Jooho Lee
ENV HOME=/opt/openGL

# Install X11 packages
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install x11vnc firefox xorg-x11-fonts* xorg-x11-xinit xorg-x11-xinit-session xorg-x11-server-Xvfb xorg-x11-twm tigervnc-server xterm xorg-x11-font dejavu-sans-fonts dejavu-serif-fonts xdotool; yum clean all

# Install Development Tools
# CentOS7
# RUN  yum -y group install "Development Tools"
# CentOS6
RUN  yum -y groupinstall "Development Tools"

# OpenGL Install
RUN yum -y install freeglut-devel glew  glew-devel

RUN mkdir -p ${HOME} && \
    chown -R 1001:0 ${HOME}/ && \
	     useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin -c "Default Application User" opengl
# Setup VNC
ADD ./xstartup ${HOME}/

RUN mkdir ~/.vnc
RUN x11vnc -storepasswd 123456 ~/.vnc/passwd
RUN cp ${HOME}/xstartup ~/.vnc/.
RUN chmod -v +x ~/.vnc/xstartup
RUN sed -i '/\/etc\/X11\/xinit\/xinitrc-common/a [ -x /usr/bin/firefox ] && /usr/bin/firefox &' /etc/X11/xinit/xinitrc

# Sample Source
ADD ./sources/example.c ${HOME}/example.c

RUN gcc ${HOME}/example.c -o examplePic -L/usr/X11R6/lib/ -lGL -lGLU -lglut 

WORKDIR ${HOME}

EXPOSE 5901

CMD    ["vncserver", "-fg" ]


