FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY MyProject.sln .
COPY aspnetapp/MyProject.csproj ./aspnetapp/
RUN dotnet restore
COPY aspnetapp/. ./aspnetapp/
WORKDIR /source/aspnetapp
RUN dotnet publish -c release -o /app --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MyProject.dll"]