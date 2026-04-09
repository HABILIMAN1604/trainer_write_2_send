using Microsoft.AspNetCore.Mvc;
using TrainerBackend.Models;
using System.Text.RegularExpressions;

namespace TrainerBackend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TrainerController : ControllerBase
{
    [HttpPost("process")]
    public IActionResult ProcessOcr([FromBody] OcrRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.RawText))
        {
            return BadRequest(new { message = "No text was provided." });
        }

        var cleanedList = ParseOcrText(request.RawText);
        
        return Ok(cleanedList);
    }

    private List<Trainee> ParseOcrText(string text)
    {
        var trainees = new List<Trainee>();
        string currentShift = "Unknown";

        // Split by lines to process one by one
        var lines = text.Split(new[] { "\n", "\r" }, StringSplitOptions.RemoveEmptyEntries);

        foreach (var line in lines)
        {
            // 1. Detect Shift (Mental note: OCR might miss "Shift", so we check for A, B, C)
            if (Regex.IsMatch(line, @"Shift\s*A", RegexOptions.IgnoreCase)) currentShift = "A";
            else if (Regex.IsMatch(line, @"Shift\s*B", RegexOptions.IgnoreCase)) currentShift = "B";
            else if (Regex.IsMatch(line, @"Shift\s*C", RegexOptions.IgnoreCase)) currentShift = "C";

            // 2. The Regex: Looks for 5-6 digits (ID), then a separator, then the name
            // Pattern: (\d{5,6}) matches digits, [.\-\s]+ matches dots, dashes or spaces
            var match = Regex.Match(line, @"(\d{5,6})[.\-\s]+([A-Za-z\s]+)");

            if (match.Success)
            {
                trainees.Add(new Trainee
                {
                    EmployeeId = match.Groups[1].Value,
                    Name = match.Groups[2].Value.Trim(),
                    Shift = currentShift
                });
            }
        }
        return trainees;
    }
}