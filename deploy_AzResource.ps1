Connect-AzAccount

New-AzResourceGroupDeployment -ResourceGroupName "HDINSIGHT-RG" -Location "eastus2" -TemplateParameterFile .\parameters.json -TemplateFile .\template.json