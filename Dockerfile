# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/node:3.0-appservice
FROM mcr.microsoft.com/azure-functions/node:4-node16

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true
    

COPY . /home/site/wwwroot

RUN cd /home/site/wwwroot && \
    npm install -g npm@8.3.0

RUN set PLAYWRIGHT_BROWSERS_PATH=/home/site/wwwroot/node_modules/playwright-chromium/.local-browsers/

RUN set NODE_TLS_REJECT_UNAUTHORIZED=0

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
