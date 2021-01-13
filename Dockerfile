FROM python:3.9-alpine3.12

ARG BUILD_DATE
ARG VERSION=1.0
LABEL build_version="yggdrasilcommodities.com version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL MAINTAINER="it@yggdrasilcommodities.com"

RUN \
 apk update && \
 echo "**** install build packages ****" && \
 apk --update add --no-cache --virtual=build-dependencies \
	libffi-dev \
	openssl-dev && \
 echo "**** install runtime packages ****" && \
 apk --update add --no-cache \
	g++ && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	pip && \
 pip install -U \
	pandas \
	azure-identity \
	azure-storage-blob && \
 echo "**** clean up ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*
