# Initial configs
$StorageAccountName = ""
$StorageAccountKey = ""
$FileshareName = ''
$templateFileName = ''
$parametersFileName = ''


$ServicePrincipalConnection = Get-AutomationConnection -Name "AzureRunAsConnection"

Write-Output "Logueando a Azure..."

Login-AzureRMAccount `
        -TenantId $ServicePrincipalConnection.TenantId `
        -CertificateThumbprint $ServicePrincipalConnection.CertificateThumbprint  `
        -ServicePrincipal `
        -ApplicationId $ServicePrincipalConnection.ApplicationId


Write-Output "Iniciando conexion a blob para obtener template y parametros.."

$Context = New-AzureStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey
Write-Output "Conexion exitosa!"
$null = Get-AzureStorageFileContent -ShareName $FileshareName -Context $Context -path $templateFileName -Destination $templateFileName
Write-Output "Template listo"
Get-AzureStorageFileContent -ShareName $FileshareName -Context $Context -path $parametersFileName -Destination $parametersFileName
Write-Output "Parametros listos"
$template = $templateFileName
$parameters = $parametersFileName

Write-Output "Empezando deploy"
New-AzureRmResourceGroupDeployment -ResourceGroupName "HDINSIGHT-RG" -TemplateFile $template -TemplateParameterFile $parameters

