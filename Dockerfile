FROM up9inc/mockintosh

ADD mockintosh-config.yaml /etc

ENTRYPOINT [ "mockintosh", "/etc/mockintosh-config.yaml" ]