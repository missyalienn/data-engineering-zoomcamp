
FROM apache/airflow:3.0.4-python3.11

ENV AIRFLOW_HOME=/opt/airflow

# SYSTEM PACKAGES (root)
USER root
RUN apt-get update -qq && apt-get install -y vim
# git gcc g++ -qqq  (uncomment if needed)

# PYTHON REQUIREMENTS (airflow user)
COPY requirements.txt .
RUN su airflow -c "pip install --no-cache-dir -r requirements.txt"

WORKDIR $AIRFLOW_HOME

# GOOGLE CLOUD SDK INSTALL (root)
USER root
ARG CLOUD_SDK_VERSION=431.0.0
ENV GCLOUD_HOME=/opt/google-cloud-sdk
ENV PATH="${GCLOUD_HOME}/bin/:${PATH}"

RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz -C /opt/ \
    && /opt/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=true \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz

# SWITCH BACK TO AIRFLOW USER FOR RUNTIME
USER ${AIRFLOW_UID}





