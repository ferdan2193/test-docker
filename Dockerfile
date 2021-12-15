FROM mcr.microsoft.com/playwright:focal

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Loggin__Console__IsEnabled=true

COPY package*.json ./

RUN node --version
RUN npm --version
CMD ["npm", "install"]
COPY . /home/site/wwwroot

CMD ["npm", "npx playwright install --with-deps"]