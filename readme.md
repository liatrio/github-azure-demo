# GitHub Actions + Azure App Service demo

This project demonstrates using GitHub Actions to test, build and deploy an application to Azure App Service.

It uses the [Realworld example application](https://github.com/gothinkster/realworld) to demonstrate the pipeline and services. The application is built using the [Realworld ASP.NET Core backend](https://github.com/gothinkster/aspnetcore-realworld-example-app) combined with the [Realworld React frontend](https://github.com/gothinkster/react-redux-realworld-example-app).

## Featured Technologies
 - [GitHub Actions](https://github.com/features/actions)
 - [GitHub Deployments](https://developer.github.com/v3/repos/deployments/)
 - [GitHub Dependabot](https://github.com/features/security)
 - [Azure App Service](https://azure.microsoft.com/en-us/services/app-service/)
 - [CodeCov](https://codecov.io/)
 - [Terraform](https://www.terraform.io/)

## Realworld Application Setup	

Install the .NET Core SDK and lots of documentation: [https://www.microsoft.com/net/download/core](https://www.microsoft.com/net/download/core)	

Documentation for ASP.NET Core: [https://docs.microsoft.com/en-us/aspnet/core/](https://docs.microsoft.com/en-us/aspnet/core/)	

## Realworld Application Docker Build	

There is a 'Makefile' for OS X and Linux:	

- `make build` executes `docker-compose build`	
- `make run` executes `docker-compose run`	

The above might work for Docker on Windows	

## Realworld Application Local building	

- It's just another C# file!   `dotnet run -p build/build.csproj`	

## Realworld Application Swagger URL	

- `http://localhost:5000/swagger`