FROM python:3.7-slim

EXPOSE 8888

ARG workspace="none"

RUN apt-get update \
    && apt-get install --assume-yes wget bash-completion unzip

# Install Jupyter Workspace for Python

RUN apt-get update \
    && apt-get install --assume-yes git curl unzip

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/pre-build.sh
RUN chmod 775 ./pre-build.sh
RUN sh pre-build.sh

WORKDIR /var/

RUN git clone https://github.com/devjudge/django-2.1-p-3.6-in-docker-2 app

WORKDIR /var/app/

# ADD TINI. TINI OPERATES AS A PROCESS SUBREAPER FOR JUPYTER. THIS PREVENTS KERNEL CRASHES.
ENV TINI_VERSION V0.6.0
ADD HTTPS://GITHUB.COM/KRALLIN/TINI/RELEASES/DOWNLOAD/${TINI_VERSION}/TINI /USR/BIN/TINI
RUN CHMOD +X /USR/BIN/TINI
ENTRYPOINT ["/USR/BIN/TINI", "--"]





# Run the app
#RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/run.sh
RUN chmod 775 ./run.sh
CMD sh run.sh
