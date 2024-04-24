#!/bin/bash

source /opt/buildpiper/shell-functions/functions.sh
source /opt/buildpiper/shell-functions/log-functions.sh
source /opt/buildpiper/shell-functions/str-functions.sh
source /opt/buildpiper/shell-functions/file-functions.sh
source /opt/buildpiper/shell-functions/aws-functions.sh
source /opt/buildpiper/shell-functions/di-functions.sh


pipeline_data_json_file="/bp/data/pipeline_context_param"

CHANGE_TICKET_ID=`fetch_change_ticket_id "$pipeline_data_json_file"`
CHANGE_TICKET_ID_DESCRIPTION=`fetch_change_ticket_id_description "$pipeline_data_json_file"`
APPLICATION_NAME=`fetch_application_name "$pipeline_data_json_file"`
SUB_TASK_JSON=`fetch_sub_tasks "$pipeline_data_json_file"`
SERVICE_JSON=`fetch_services "$pipeline_data_json_file"`

export APPLICATION_NAME
export SERVICE_JSON
export CHANGE_TICKET_ID
export CHANGE_TICKET_ID_DESCRIPTION
export SUB_TASK_JSON

generateDIDataJson /opt/buildpiper/data/di.template deployment.di

sendDIData deployment.di 

TASK_STATUS=$?
if [ ${TASK_STATUS} -eq 0 ]
then
  TASK_STATUS=0
  logInfoMessage "deploymenent insight info sent!!!"

else
  logWarningMessage "failed while calling deployement insight api!!"
   TASK_STATUS=1
   exit 1
fi

saveTaskStatus ${TASK_STATUS} ${ACTIVITY_SUB_TASK_CODE}
