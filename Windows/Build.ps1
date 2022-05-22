[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $LTSC = "2019",

    [Parameter()]
    [switch]
    $Isolation
)

$Tag = "dechertnicholas/vrising-dedicated-server:ltsc$LTSC"
$LTSC = "mcr.microsoft.com/windows/servercore:ltsc$LTSC"

if (-not $env:GITHUB_ACTIONS) {
    $Tag += "-local" # Differentiate local builds
    if ($Isolation) {
        docker build --isolation hyperv --build-arg "LTSC=$LTSC" . -t $Tag
    } else {
        docker build --build-arg "LTSC=$LTSC" . -t $Tag
    }
    
} else {
    docker build --build-arg "LTSC=$LTSC" . -t $Tag
}