#!/bin/bash -e

proj=src/DnsClient/DnsClient.csproj
dotnet restore $proj
dotnet build $proj

