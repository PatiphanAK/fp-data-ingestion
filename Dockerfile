FROM sbtscala/scala-sbt:eclipse-temurin-alpine-21.0.8_9_1.11.7_2.13.18 AS builder

WORKDIR /app
COPY build.sbt .
COPY project ./project
RUN sbt update
COPY src ./src
RUN sbt clean package

ENV SPARK_HOME=/opt/spark
ENV PATH="${SPARK_HOME}/bin:${SPARK_HOME}/sbin:${PATH}"
FROM spark:4.0.1-scala2.13-java21-ubuntu
USER root

RUN set -ex; \
    apt-get update; \
    apt-get install -y r-base r-base-dev; \
    rm -rf /var/lib/apt/lists/*

ENV R_HOME=/usr/lib/R

WORKDIR /opt/spark/app
COPY --from=builder /app/target/scala-2.13/*.jar app.jar
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV SPARK_APPLICATION_JAR=/opt/spark/app/app.jar

ENTRYPOINT ["/entrypoint.sh"]
