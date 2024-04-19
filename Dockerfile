FROM alpine

RUN apk add --no-cache --upgrade bash
RUN apk add jq
RUN apk add gettext libintl curl

ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD BP-BASE-SHELL-STEPS/data /opt/buildpiper/data

ENV BP_API_URL ""
ENV ACTIVITY_SUB_TASK_CODE BP-DEPLOYEMENT-INSIGHT

COPY build.sh .
ENTRYPOINT [ "./build.sh" ]
