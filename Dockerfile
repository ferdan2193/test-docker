# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/node:3.0-appservice
FROM mcr.microsoft.com/azure-functions/node:4-node16

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    PLAYWRIGHT_BROWSERS_PATH=/home/site/wwwroot/node_modules/playwright-chromium/local-browsers/ \
    NODE_TLS_REJECT_UNAUTHORIZED=0 \
    AzureWebJobsStorage="DefaultEndpointsProtocol=https;AccountName=fstoragetestdocker;AccountKey=xmS8Ljan9nplvDaZZCUGgyHsQxev8h/Nc66PYwOpuVN2Wfu5UlOyI+39zoJg8ilQkeruo562My72lUF2UOBwDA==;EndpointSuffix=core.windows.net" \
    APPINSIGHTS_INSTRUMENTATIONKEY=b403b622-4ecd-4ab5-9200-b973f556a4c0

#This works to enable ssh in advanced tools
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd
 
COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/
 
RUN chmod u+x /usr/local/bin/init.sh
#Until here
#Install dependencies
RUN apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && apt-get install -y curl
RUN mkdir dependencies
RUN cd dependencies && \
    curl http://ftp.de.debian.org/debian/pool/non-free/f/fonts-ubuntu/fonts-ubuntu_0.83-4_all.deb -o fontubuntu.deb && \
    curl http://ftp.de.debian.org/debian/pool/non-free/f/fonts-ubuntu/ttf-ubuntu-font-family_0.83-4_all.deb -o ttfubuntu.deb && \
    curl http://archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_2.0.3-0ubuntu1_amd64.deb -o libjpeg.deb && \
    curl http://archive.ubuntu.com/ubuntu/pool/universe/e/enchant/libenchant1c2a_1.6.0-11.3build1_amd64.deb -o libenchant1c2a.deb && \
    curl http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu66_66.1-2ubuntu2_amd64.deb -o libicu66.deb

RUN cd dependencies && \
    apt-get install libc6 && \
    dpkg -i fontubuntu.deb && \
    dpkg -i ttfubuntu.deb && \
    dpkg -i libjpeg.deb && \
    dpkg -i libicu66 && \
    dpkg -i libenchant1c2a.deb && \
    apt --fix-broken install
#

COPY . /home/site/wwwroot

RUN cd /home/site/wwwroot && \
    npm install -g npm@8.3.0

RUN export PLAYWRIGHT_BROWSERS_PATH="/home/site/wwwroot/node_modules/playwright-chromium/local-browsers/"

RUN export NODE_TLS_REJECT_UNAUTHORIZED="0"

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
EXPOSE 80 2222
ENTRYPOINT ["init.sh"]

