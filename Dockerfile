FROM tleyden5iwx/caffe-cpu-master
MAINTAINER awentzonline

RUN /opt/caffe/data/ilsvrc12/get_ilsvrc_aux.sh
RUN python /opt/caffe/scripts/download_model_binary.py \
  /opt/caffe/models/bvlc_googlenet

ADD ./webapp /webapp
WORKDIR /webapp
RUN pip install -r requirements.txt

EXPOSE 8080
CMD ["python", "/webapp/app.py", "-p 8080", "-d"]
