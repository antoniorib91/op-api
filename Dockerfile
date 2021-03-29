FROM amberframework/amber:0.36.0

WORKDIR /app

COPY shard.* /app/
RUN shards install

COPY . /app

CMD amber watch
