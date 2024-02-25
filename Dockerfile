FROM jupyterhub/jupyterhub

COPY . /jhub_screener/


RUN apt-get update && apt-get -y install npm nodejs python3 python3-pip git nano cron

RUN python3 -m pip install -r /jhub_screener/requirements.txt

RUN cd /usr/local/ && git clone https://github.com/jupyterhub/configurable-http-proxy &&\
                      cd configurable-http-proxy && npm install

RUN cd /home && git clone https://github.com/jupyterhub/nativeauthenticator.git &&\
                cd nativeauthenticator && pip3 install -e .

WORKDIR /etc/jupyterhub

RUN jupyterhub --generate-config -f jupyterhub_config.py &&\
                 cp /jhub_screener/jupyterhub_config.py jupyterhub_config.py

RUN cp /jhub_screener/scripts/cronfile /etc/cron.d/cronfile &&\
                  chmod 0644 /etc/cron.d/cronfile &&  crontab /etc/cron.d/cronfile

RUN chmod 755 /jhub_screener/start.sh

CMD ["/jhub_screener/start.sh"]
