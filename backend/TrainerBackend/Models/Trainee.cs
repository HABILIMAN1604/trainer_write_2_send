namespace TrainerBackend.Models;

public class Trainee
{
    public string EmployeeId { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Shift { get; set; } = string.Empty;
}

public class OcrRequest
{
    public string RawText { get; set; } = string.Empty;
}