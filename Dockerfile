FROM nvidia/cuda:7.5-cudnn5-devel-ubuntu14.04
MAINTAINER Yehor Tsebro <egortsb@gmail.com>
#Update pip
RUN apt-get update -y && apt-get install apt-utils -y && apt-get upgrade -y && apt-get install git python3 python3-pip python3-cffi unzip wget -y && pip3 install --upgrade pip


RUN sudo apt-get install -y pkg-config  graphviz libgraphviz-dev  python-tk
RUN pip3 install pygraphviz

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN mkdir -p  /opt/dls

ADD app /opt/dls/app
ADD data /opt/dls/data
ADD data-test /opt/dls/data-test
ADD data-design /opt/dls/data-design
ADD run-app.py /opt/dls/run-app.py
ADD config.py /opt/dls/config.py
ADD requirements.txt /opt/dls/requirements.txt

WORKDIR /opt/dls
RUN npm install grunt-cli -g
#RUN npm install

RUN sudo pip3 install -r requirements.txt
RUN pip3 install toposort
RUN pip3 install h5py
#RUN grunt
CMD python3 run-app.py
