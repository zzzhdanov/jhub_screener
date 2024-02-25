#!/bin/sh

jupyterhub -f /etc/jupyterhub/jupyterhub_config.py & cron -f
