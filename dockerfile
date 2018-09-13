FROM centos:latest
LABEL Maintainer="vaibhav"

CMD ["/usr/bin/mkdir" "/opt/mytest"]
COPY add.sh /opt/mytest/
