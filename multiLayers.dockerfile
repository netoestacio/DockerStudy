FROM python:slim as dependecy
WORKDIR /reqs
COPY requirements.txt /reqs
RUN pip install -r requirements.txt

FROM node:lts as packasges
WORKDIR /packages
COPY package.json .
RUN npm install

FROM python:slim
RUN apt-get update --no-install-recommends && apt-get install nodejs -y --no-install-recommends
WORKDIR /home/app
COPY ./code/ .
COPY --from=dependecy /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages/
COPY --from=packages /packages/node_modules /home/app/node_modules
