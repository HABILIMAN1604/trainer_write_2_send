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

        // Change: Now we receive a full Report object instead of just a List
        var report = ParseOcrText(request.RawText);
        
        return Ok(report);
    }

    // Change: The return type is now TrainingReport
    private TrainingReport ParseOcrText(string text)
    {
        var report = new TrainingReport();
        string currentShift = "Unknown";

        var lines = text.Split(new[] { "\n", "\r" }, StringSplitOptions.RemoveEmptyEntries);

        foreach (var line in lines)
        {
            // --- 1. DETECT HEADER INFO (Use the ORIGINAL line) ---
            // We use the original line so "August" isn't turned into "Au6ust" yet
            var dateMatch = Regex.Match(line, @"(\d{1,2})[^0-9A-Za-z]+([A-Za-z]+)[^0-9A-Za-z]+(\d{4})");

            if (dateMatch.Success)
            {
                report.DateJoin = $"{dateMatch.Groups[1].Value} {dateMatch.Groups[2].Value} {dateMatch.Groups[3].Value}";
                continue; // Skip to next line if we found the date
            }
            
            if (line.Contains("day", StringComparison.OrdinalIgnoreCase))
            {
                report.TrainingDay = Regex.Match(line, @"\d+").Value;
                continue;
            }
            
            if (line.Contains("loc", StringComparison.OrdinalIgnoreCase))
            {
                report.Location = Regex.Match(line, @"\d+").Value;
                continue;
            }

            // --- 2. DETECT SHIFT (Use original line) ---
            if (Regex.IsMatch(line, @"Shift\s*A", RegexOptions.IgnoreCase)) currentShift = "A";
            else if (Regex.IsMatch(line, @"Shift\s*B", RegexOptions.IgnoreCase)) currentShift = "B";
            else if (Regex.IsMatch(line, @"Shift\s*C", RegexOptions.IgnoreCase)) currentShift = "C";

            // --- 3. CLEAN THE LINE FOR TRAINEE DETECTION ONLY ---
            // Now it's safe to turn g->6 because we already checked for the word "August"
            string cleanLine = line
                .Replace("G", "6").Replace("g", "6")
                .Replace("o", "0").Replace("O", "0")
                .Replace("q", "9").Replace("Q", "9");

            // --- 4. DETECT TRAINEES ---
            var match = Regex.Match(cleanLine, @"(\d{5,6})[.\-\s]+([A-Za-z\s]+)");
            if (match.Success)
            {
                report.Trainees.Add(new Trainee
                {
                    EmployeeId = match.Groups[1].Value,
                    Name = match.Groups[2].Value.Trim(),
                    Shift = currentShift
                });
            }
        }
        return report;
    }
}