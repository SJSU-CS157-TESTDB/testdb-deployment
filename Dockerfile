FROM postgres:13

ENV POSTGRES_DB testdb
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD .


COPY ./scripts/*.sql /docker-entrypoint-initdb.d/