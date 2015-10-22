FROM ubuntu:14.04
MAINTAINER awentzonline

RUN apt-get update -y && apt-get install -y \
  libprotobuf-dev libleveldb-dev \
  libsnappy-dev libopencv-dev \
  libhdf5-serial-dev protobuf-compiler \
  libatlas-base-dev \
  python-dev python-pip \
  libgflags-dev libgoogle-glog-dev liblmdb-dev
RUN apt-get install -y --no-install-recommends libboost-all-dev
RUN apt-get install -y \
  python-numpy python-scipy python-matplotlib \
  python-pandas cython python-skimage python-h5py

ADD ./vendor /app/vendor
WORKDIR /app/vendor/caffe/python
RUN pip install -r requirements.txt
WORKDIR /app/vendor/caffe
ADD ./conf /app/conf
RUN cp /app/conf/Makefile.config /app/vendor/caffe
RUN make all && make test
