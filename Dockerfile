FROM node:8-stretch

RUN apt update -yqqq
RUN apt upgrade -y
RUN apt install unzip \
    openjdk-8-jdk \
    ca-certificates \
    wget -y 

RUN wget -q http://cdn.sencha.com/cmd/7.0.0.40/no-jre/SenchaCmd-7.0.0.40-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-7.0.0.40-linux-amd64.sh.zip
RUN ./SenchaCmd-7.0.0.40-linux-amd64.sh -q -dir "/usr/local/Sencha/Cmd/7.0.0.40"
RUN ln -s /usr/local/Sencha/Cmd/sencha /usr/local/bin/sencha
RUN rm SenchaCmd-7.0.0.40-linux-amd64.sh.zip
RUN rm SenchaCmd-7.0.0.40-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*