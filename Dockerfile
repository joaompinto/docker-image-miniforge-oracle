FROM condaforge/miniforge3
ENV instant_client_version=21.1.0.0.0

RUN apt-get update > /dev/null && \
    apt-get install --no-install-recommends --yes \
        libaio1 > /dev/null && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN cd /tmp \
    && wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-$instant_client_version.zip \
    && python -m zipfile -e /tmp/instantclient-basic-linux.x64-$instant_client_version.zip /opt \
    && rm -f /tmp/instantclient-basic-linux.x64-$instant_client_version.zip

RUN conda install cx_oracle && conda clean --all -f 

RUN rm -f /opt/instantclient_21_1/libclntsh.so && ln -s /opt/instantclient_21_1/libclntsh.so.21.1 /opt/instantclient_21_1/libclntsh.so 

ENV LD_LIBRARY_PATH=/opt/instantclient_21_1

