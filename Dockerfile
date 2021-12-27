# To enable ssh & remote debugging on app service change the base image to the one below
# FROM mcr.microsoft.com/azure-functions/node:3.0-appservice
FROM mcr.microsoft.com/azure-functions/node:4-node16

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true \
    PLAYWRIGHT_BROWSERS_PATH=/home/site/wwwroot/node_modules/playwright-chromium/.local-browsers/



COPY . /home/site/wwwroot

RUN cd /home/site/wwwroot && \
    npm install

RUN cd /home/site/wwwroot && \
    npx playwright install --with-deps