FROM python:3.9.7-slim-bullseye

# Don't use cached python packages
ENV PIP_NO_CACHE_DIR 1

# Installing Required Packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    bash \
    python3-dev \
    python3-lxml \
    gcc \
    git \
    make \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

# Enter Workplace
RUN git clone -b main https://github.com/ZauteKm/Alita_Robot /root/Alita_Robot
WORKDIR /root/Alita_Robot

# Copy folder
COPY ./alita/vars.py ./alita/vars.py* /root/alita/alita/

ENV PATH="/home/bot/bin:$PATH"

# Install dependencies
RUN pip3 install --upgrade pip

# Install Bot Deps and stuff
RUN pip3 install -U -r requirements.txt

# Run the bot
ENTRYPOINT ["python3","-m","alita"]
