# Étape de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /build

COPY ./firstAppColify.csproj ./Front/
RUN dotnet restore "./Front/firstAppColify.csproj"
COPY . ./Front
WORKDIR /build/Front
RUN dotnet publish -c Release -o /app/publish

FROM  mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS run

WORKDIR /app
EXPOSE 8080
EXPOSE 443

COPY --from=build /app/publish .
ENTRYPOINT [ "dotnet","firstAppColify.dll" ]
