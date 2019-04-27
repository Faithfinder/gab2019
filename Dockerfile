FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["GABDemo/GABDemo.csproj", "GABDemo/"]
RUN dotnet restore "GABDemo/GABDemo.csproj"
COPY . .
WORKDIR "/src/GABDemo"
RUN dotnet build "GABDemo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "GABDemo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "GABDemo.dll"]
