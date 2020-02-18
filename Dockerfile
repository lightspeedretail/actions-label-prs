FROM alpine:3.10.3

LABEL "com.github.actions.name"="Label pull requests"
LABEL "com.github.actions.description"="Auto-label pull requests actions"
LABEL "com.github.actions.icon"="tag"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"

RUN apk add --no-cache bash curl jq

ADD entrypoint.sh /entrypoint.sh
ADD actions /actions

ENTRYPOINT ["/entrypoint.sh"]