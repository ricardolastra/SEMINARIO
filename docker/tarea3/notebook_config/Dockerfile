FROM python:3.6-slim

RUN pip install py2neo jupyterlab psycopg2 pandas matplotlib sqlalchemy sklearn scipy networkx

ENV HOME_USER jupyter
ENV HOME_PASS password

RUN useradd -m -s /bin/bash ${HOME_USER} && \
    echo "${HOME_USER}:${HOME_PASS}"|chpasswd && \
    adduser ${HOME_USER} sudo && \
    echo ${HOME_USER}' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER jupyter
RUN mkdir -p /home/jupyter/workspace
WORKDIR /home/jupyter/workspace
COPY . /home/jupyter/workspace


ENV PASSWORD=password
