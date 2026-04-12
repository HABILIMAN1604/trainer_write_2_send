namespace TrainerBackend.Models;

public class Trainee
{
    public string EmployeeId { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Shift { get; set; } = string.Empty;
}

public class TrainingReport
{
    public string DateJoin { get; set; } = string.Empty;
    public string TrainingDay { get; set; } = string.Empty;
    public string Location { get; set; } = string.Empty;
    public List<Trainee> Trainees { get; set; } = new List<Trainee>();
}