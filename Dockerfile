FROM 759271050724.dkr.ecr.us-east-1.amazonaws.com/iv-jetty-base-ami:latest
# Download App Specific Config Files
ENV JETTY_BASE /usr/local/jetty/jetty_base
RUN aws s3 sync s3://ivrepo/docker-app-wise/rcview/ $JETTY_BASE/
ENV JETTY_HOME /usr/local/jetty
ENV PATH $JETTY_HOME/bin:$PATH

ENV TMPDIR /usr/local/tmp
RUN chown -R jetty:jetty "$TMPDIR"
RUN chown -R jetty:jetty /usr/local/jetty/jetty_base/logs

USER jetty
EXPOSE 8080
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["java","-jar","/usr/local/jetty/start.jar"]
