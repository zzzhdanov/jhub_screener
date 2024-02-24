FROM jupyterhub/jupyterhub

COPY . /jhub_screener/

RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

RUN apt update && apt-get -y install npm nodejs python3 python3-pip git nano && apt install cron

RUN python3 -m pip install -r /jhub_screener/requirements.txt

RUN cd /usr/local/ && git clone https://github.com/jupyterhub/configurable-http-proxy &&\
                      cd configurable-http-proxy && npm install

RUN cd /home && git clone https://github.com/jupyterhub/nativeauthenticator.git &&\
                cd nativeauthenticator && pip3 install -e .

WORKDIR /etc/jupyterhub

RUN jupyterhub --generate-config -f jupyterhub_config.py &&\
                 cp /jhub_screener/jupyterhub_config.py jupyterhub_config.py

RUN echo "* * * * * cd /jhub_screener/scripts && python3 cronscript.py" | crontab -

RUN jupyterhub -f /etc/jupyterhub/jupyterhub_config.py
