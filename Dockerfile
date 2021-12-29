# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/node:3.0-appservice
FROM ubuntu:21.04

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    PLAYWRIGHT_BROWSERS_PATH=/home/site/wwwroot/node_modules/playwright-chromium/local-browsers/ \
    NODE_TLS_REJECT_UNAUTHORIZED=0 \
    AzureWebJobsStorage="DefaultEndpointsProtocol=https;AccountName=fstoragetestdocker;AccountKey=xmS8Ljan9nplvDaZZCUGgyHsQxev8h/Nc66PYwOpuVN2Wfu5UlOyI+39zoJg8ilQkeruo562My72lUF2UOBwDA==;EndpointSuffix=core.windows.net" \
    APPINSIGHTS_INSTRUMENTATIONKEY="b403b622-4ecd-4ab5-9200-b973f556a4c0"



#This works to enable ssh in advanced tools
#ENV SSH_PASSWD "root:Docker!"
#RUN apt-get update \
#    && apt-get install -y --no-install-recommends openssh-server \
#    && echo "$SSH_PASSWD" | chpasswd
 
#COPY sshd_config /etc/ssh/
#COPY init.sh /usr/local/bin/
 
#RUN chmod u+x /usr/local/bin/init.sh
#Until here

#Install node
ENV NODE_VERSION=16.13.1
RUN apt-get update
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version
#End install node



COPY . /home/site/wwwroot

RUN cd /home/site/wwwroot && \
    npm install -g npm@8.3.0

RUN export PLAYWRIGHT_BROWSERS_PATH=/home/site/wwwroot/node_modules/playwright-chromium/local-browsers/

RUN export NODE_TLS_REJECT_UNAUTHORIZED=0

RUN cd /home/site/wwwroot && \
    npm install playwright --verbose

RUN cd /home/site/wwwroot && \
    npm install playwright-core --verbose

RUN cd /home/site/wwwroot && \
    npm install playwright-chromium --verbose

RUN cd /home/site/wwwroot && \
    npm install @playwright/test --verbose

RUN cd /home/site/wwwroot && \
    npm install ceruleoscope --verbose

RUN cd /home/site/wwwroot && \
    npm install applicationinsights --verbose

RUN cd /home/site/wwwroot && \    
    npx playwright install --with-deps

RUN cd /home/site/wwwroot && \    
    npx playwright install-deps

RUN cd /home/site/wwwroot && \    
    npx playwright install
#We expose the port to enable ssh
#EXPOSE 80 2222
#ENTRYPOINT ["init.sh"]

