FROM perl:5.22

COPY . /RocksBot
WORKDIR /RocksBot
RUN perl ./Makefile.PL
RUN make

CMD ["perl", "./rocksbot.pl"]
