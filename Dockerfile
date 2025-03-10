FROM debian:buster

LABEL maintainer="vinicius.tr@gmail.com"

RUN apt-get clean && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    gdebi \
    wget \
    python-pip

WORKDIR /tmp

RUN wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.buster_amd64.deb && \
    gdebi --n wkhtmltox_0.12.6-1.buster_amd64.deb && \
    rm wkhtmltox_0.12.6-1.buster_amd64.deb

RUN ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
RUN ln -s /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage

WORKDIR /usr/src

COPY app.py ./app.py
COPY requirements.txt ./requirements.txt

RUN pip install -r requirements.txt

EXPOSE 80

CMD ["python", "app.py"]
