Connect-AzAccount #-Identity if its on a VM with a managed identity assigned, doesnt ask for credentials.

New-AzResourceGroupDeployment -ResourceGroupName "HDINSIGHT-RG" -Location "eastus2" -TemplateParameterFile .\parameters.json -TemplateFile .\template.json
