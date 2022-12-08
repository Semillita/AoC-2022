$text = Get-Content -Path $PSScriptRoot\Input6.txt

function Get-Index($data, $length) {
    for ($i = 0; $i -lt ($text.Length - ($length - 1)); $i++) {
        $chars = New-Object System.Collections.Generic.HashSet[string]

        for ($j = 0; $j -lt $length; $j++) {
            $charAt = $text.Substring(($i + $j), 1)
            $ignored = $chars.Add($charAt)
        }
    
        if ($chars.Count -ge $length) {
            return $i + $length
        }
    }
}

Write-Host("Part 1: $(Get-Index $text 4)")
Write-Host("Part 2: $(Get-Index $text 14)")