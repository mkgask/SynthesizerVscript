FROM alpine:3.14.2

RUN apk --no-cache add \
    curl \
    bash

RUN curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash

CMD /bin/sh