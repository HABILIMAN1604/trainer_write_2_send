//this part is to import Scalar (must install first) dotnet add package Scalar.AspNetCore
using Scalar.AspNetCore;

//a skeleton. also read from appsettings.json
var builder = WebApplication.CreateBuilder(args);

//scan controllers folder
builder.Services.AddControllers();

// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();



//tur the builder alive
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.MapScalarApiReference(options => 
    {
        options.WithTitle("Trainer OCR API")
               .WithTheme(ScalarTheme.DeepSpace) // Optional: Makes it look cool
               .WithDefaultHttpClient(ScalarTarget.CSharp, ScalarClient.HttpClient);
    });
}

//force to use Https instead of Http
app.UseHttpsRedirection();

//this is for security later
app.UseAuthorization();

//connect doors such as /api/trainer
app.MapControllers();

//the infinite loop listen to server for request
app.Run();
