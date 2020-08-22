FROM python:3.7-slim

EXPOSE 8888

ARG workspace="none"

RUN apt-get update \
    && apt-get install --assume-yes wget bash-completion unzip git curl

# Install Jupyter Workspace for Python

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/pre-build.sh
RUN chmod 775 ./pre-build.sh
RUN sh pre-build.sh

WORKDIR /var/


RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/download-repo.sh
RUN chmod 775 ./download-repo.sh
RUN sh download-repo.sh


WORKDIR /var/app/

# ADD TINI. TINI OPERATES AS A PROCESS SUBREAPER FOR JUPYTER. THIS PREVENTS KERNEL CRASHES.
# ENV TINI_VERSION V0.6.0
# ADD HTTPS://GITHUB.COM/KRALLIN/TINI/RELEASES/DOWNLOAD/${TINI_VERSION}/TINI /USR/BIN/TINI
# RUN CHMOD +X /USR/BIN/TINI
# ENTRYPOINT ["/USR/BIN/TINI", "--"]





# Run the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/run-3.sh
RUN chmod 775 ./run-3.sh
CMD bash run-3.sh
