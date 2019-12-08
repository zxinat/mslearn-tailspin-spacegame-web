FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj", "Tailspin.SpaceGame.Web/"]
RUN dotnet restore "Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj"
COPY . .
WORKDIR "/src/Tailspin.SpaceGame.Web"
RUN dotnet build "Tailspin.SpaceGame.Web.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Tailspin.SpaceGame.Web.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Tailspin.SpaceGame.Web.dll"]