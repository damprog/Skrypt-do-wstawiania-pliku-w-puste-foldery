$Policy = Get-ExecutionPolicy -Scope Process
if($Policy -ne "RemoteSigned") {
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
Write-Output "Ustawiono polityke wykonania dla tego procesu na RemoteSigned"
}
else {
Write-Output "Polityka wykonania jest odpowiednia"
}
if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{Write-Output 'Uruchomiono jako Administrator!'}
else
{Write-Output 'Uruchomiono z ograniczeniami!'}
Pause


$Path="C:\Users\Prezes\Desktop\testFolder"


Function Search-Empty-Dir($path)
{
$global:EmptyCount = 0
$subFolders = get-childitem $path -Recurse | Where-Object {$_.PSIsContainer -eq $True}
if($subFolders)
{
foreach($folder in $subFolders)
{
if($folder.PSisContainer)
{
$currLocation = $folder.fullname
$Quantity = Get-ChildItem $currLocation -Recurse | Measure-Object
if($Quantity.Count -eq 0)
{
Write-Output $folder
Write-Output 'Folder jest pusty'
$infoIlosc = "Folder zawiera " + $Quantity.Count + " elementow"
Write-Output $infoIlosc
$global:EmptyCount+=1
}
else
{
Write-Output $folder
Write-Output 'Folder NIE jest pusty'
$infoIlosc = "Folder zawiera " + $Quantity.Count + " elementow"
Write-Output $infoIlosc
}
}
}
}
}

Function Add-File-To-Empty-Dir($path)
{
$AddedFiles = 0
$subFolders = get-childitem $path -Recurse | Where-Object {$_.PSIsContainer -eq $True}
if($subFolders)
{
foreach($folder in $subFolders)
{
if($folder.PSisContainer)
{
$currLocation = $folder.fullname
$Quantity = Get-ChildItem $currLocation -Recurse | Measure-Object
if($Quantity.Count -eq 0)
{
$TxtLoc = $currLocation
New-Item -Path $TxtLoc -Name TxtFileTxt.txt -ItemType File -Value "Plik utworzony przez skrypt"
Write-Output "Dodano plik"
$AddedFiles+=1
}
}
}
}
$infoAfter = "Dodano pliki do " + $AddedFiles + " folderow"
Write-Output $infoAfter
}

Search-Empty-Dir($Path)
Pause
cls
$infoBefore = "Znaleziono " + $EmptyCount + " pustych folderow"
Write-Output $infoBefore
Write-Output "Czy chcesz dodac do nich plik? [tak/nie]"
$odp = Read-Host
if($odp -eq "tak")
{
Add-File-To-Empty-Dir($Path)
}
Pause