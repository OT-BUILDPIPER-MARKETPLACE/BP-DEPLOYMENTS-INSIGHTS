FROM python:slim-buster

# Update package list and install required packages
RUN apt-get update && apt-get install \
    bash \
    jq \
    gettext-base \
    curl -y 


# Install Python packages from requirements.txt
COPY requirement.txt .

RUN  pip install --upgrade pip && pip install -r requirement.txt

# Add your shell scripts and data
ADD BP-BASE-SHELL-STEPS /opt/buildpiper/shell-functions/
ADD BP-BASE-SHELL-STEPS/data /opt/buildpiper/data

# Set environment variables
ENV BP_API_URL ""
ENV USER_NAME  ""
ENV PASSWORD ""
ENV JIRA_OPS=false 
ENV ACTIVITY_SUB_TASK_CODE BP-DEPLOYEMENT-INSIGHT
ENV APPLICATION_NAME ""

# Copy the build script and Python script
COPY build.sh .
COPY subtask_info.py .

# Set the entrypoint to the build script
ENTRYPOINT ["./build.sh"]
