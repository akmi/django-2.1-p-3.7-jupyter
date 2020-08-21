FROM python:3.7-slim

EXPOSE 8888

ARG workspace="none"

RUN apt-get update \
    && apt-get install --assume-yes wget bash-completion unzip

# Install Jupyter Workspace for Python 

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/pre-build.sh
RUN chmod 775 ./pre-build.sh 
RUN sh pre-build.sh

# End Install for Workspace  

WORKDIR /var/app

ADD . .

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]


# Run the app
#RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/run.sh
#RUN chmod 775 ./run.sh
#CMD sh run.sh
