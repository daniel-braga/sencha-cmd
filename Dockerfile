FROM node:8-stretch

RUN apt update -yqqq
RUN apt upgrade -y
RUN apt install unzip \
    openjdk-8-jdk \
    ca-certificates \
    wget -y 

RUN wget -q http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN ./SenchaCmd-6.7.0.63-linux-amd64.sh -q -dir "/usr/local/Sencha/Cmd/6.7.0.63"
RUN ln -s /usr/local/Sencha/Cmd/sencha /usr/local/bin/sencha
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*