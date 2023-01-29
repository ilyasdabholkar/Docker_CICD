#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
EXPOSE 7078

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["DummyApi/DummyApi.csproj", "DummyApi/"]
RUN dotnet restore "DummyApi/DummyApi.csproj"
COPY . .
WORKDIR "/src/DummyApi"
RUN dotnet build "DummyApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DummyApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DummyApi.dll"]