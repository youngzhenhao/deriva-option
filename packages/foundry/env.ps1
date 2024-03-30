$envFileContent = Get-Content -Path ".env"

foreach ($line in $envFileContent) {
    if ($line -match '^(.*?)="?(.*)"?$') {
        $variableName = $matches[1]
        $variableValue = $matches[2]
        Set-Item -Path "env:$variableName" -Value $variableValue
        Write-Host "`$env:${variableName}: ${variableValue}"
    }
}
