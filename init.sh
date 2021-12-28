#!/bin/bash
set -e

echo "Starting SSH ..."
service ssh start

./azure-functions-host/Microsoft.Azure.WebJobs.Script.WebHost