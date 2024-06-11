# BP-DEPLOYMENTS-INSIGHTS
A BP step to do sonar scanning

## Setup
* Clone the code available at [BP-DEPLOYMENTS-INSIGHTS](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-DEPLOYMENTS-INSIGHTS)
* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/deployment-insight:0.1 .
```

ENV REQUIRED IN BP step Catalog are
***variable name***  ***value***
WORKSPACE       /bp/workspace
BP_API_URL     <your-insight-api-url>
USER_NAME      <user name>
PASSWORD       <password>
