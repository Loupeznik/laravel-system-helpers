echo "Artisan model generator"
echo "Created by Loupeznik (https://github.com/Loupeznik)"

if (!(Test-Path ".\artisan" -PathType Leaf)) {
  Write-Host "ERROR: Artisan not found in this directory" -ForegroundColor red
  Write-Host "Exiting" -ForegroundColor red
  exit
}

$input = Read-Host -Prompt "Enter model names separated by commas"

if (!$input) {
  Write-Host "ERROR: No model names entered" -ForegroundColor red
  Write-Host "Exiting" -ForegroundColor red
  exit
}

echo "Enter switches to create additional classes, like controllers, no switch will be used if the field is left blank"
echo "Available switches m - migration, s - seeder, f - factory, c - controller (-msfc)"
$switch = Read-Host -Prompt "Enter the desired switches"

if (!$switch) {
  Write-Host "WARNING: No switch selected" -ForegroundColor yellow
} else {
  if ($switch -notcontains "-") {
    $switch = "-" + $switch
  }
  if ($switch -notmatch "[mscf]") {
    Write-Host "ERROR: The switch can contain only [mscf] characters" -ForegroundColor red
    Write-Host "Exiting" -ForegroundColor red
    exit
  }
}

$input = $input -replace '\s',''
$switch = $switch -replace '\s',''
$models = $input.Split(",")

foreach ($model in $models) {
  Write-Host "Creating model $model" -ForegroundColor green
  php artisan make:model $model $switch
}
