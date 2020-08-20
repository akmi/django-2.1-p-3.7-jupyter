FROM python:3.7-slim

EXPOSE 8888

ARG workspace="none"

RUN apt-get update \
    && apt-get install --assume-yes wget bash-completion unzip

# Install Jupyter Workspace for Python 

RUN if [ $workspace = "jupyter" ] ; then \
	wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/pre-build.sh \
    && chmod 775 ./pre-build.sh && sh pre-build.sh ; fi

# End Install for Workspace  

WORKDIR /var/app

ADD . .

# Run the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/jupyter/run.sh
RUN chmod 775 ./run.sh
CMD sh run.sh
