
$vmname = "lin01"
$location = "westus"
$Tags = @{ CompanyCode = '0322' ; CostElement = 'YCP7300' ; Owneremail = 'cpetricko@chevron.com' ; ProjectName = 'test' ; Owner = 'test' ; EnvName = 'test'}

$RG = New-AzResourceGroup -Name "testRG1" -Location "westus"
Update-AzTag -ResourceId $RG.id -Tag $Tags -Operation Merge
#$vnet = Get-AzVirtualNetwork -Name "ABRO-DEV-TLOG-RG-vnet" -ResourceGroupName "ABRO-DEV-TLOG-RG"
#$subnetid = (Get-AzVirtualNetworkSubnetConfig -Name 'default' -VirtualNetwork $vnet).Id

# Create a subnet configuration
New-AzVirtualNetworkSubnetConfig -Name "testsubnet"  -AddressPrefix 10.0.10.0/25
$subnetConfig = New-AzVirtualNetworkSubnetConfig -Name "testsubnet" -AddressPrefix 10.0.10.0/25 

# Create a virtual network
$vnet = New-AzVirtualNetwork -ResourceGroupName "testRG1" -Location $location -Name "testvnet" -AddressPrefix 10.0.10.0/24 -Subnet $subnetConfig
# Create a virtual network card and associate with public IP address and NSG $nic = New-AzNetworkInterface `   -Name "myNic" `   -ResourceGroupName "myResourceGroup" `   -Location "EastUS" `   -SubnetId $vnet.Subnets[0].Id `   -PublicIpAddressId $pip.Id `   -NetworkSecurityGroupId $nsg.Id
Set-AzResource -ResourceGroupName "testRG1" ‑ResourceType $vnet.Type -ResourceName $vnet.Name -Tag @{ CompanyCode = '0322' ; CostElement = 'YCP7300' ; Owneremail = 'cpetricko@chevron.com' ; ProjectName = 'test' ; Owner = 'test' ; EnvName = 'test'} -Force

#$nsg = New-AzNetworkSecurityGroup -ResourceGroupName "testRG1" -Name "$vmname-nsg" -Location $location
#$nic = New-AzNetworkInterface -Name "testvmnic" -ResourceGroupName "testRG1" -Location $location -SubnetId $vnet.Subnets[0].Id -NetworkSecurityGroupId $nsg.Id
#$nic = New-AzNetworkInterface -Name "myNic" -ResourceGroupName "suader01" -Location "southindia" -SubnetId $vnet.Subnets[0].Id -NetworkSecurityGroupId $nsg.Id
$nic = New-AzNetworkInterface -Name "myNic" -ResourceGroupName "testRG1" -Location "westus" -SubnetId $vnet.Subnets[0].Id
# -NetworkSecurityGroupId $nsg.Id
Set-AzResource -ResourceGroupName "testRG1" ‑ResourceType $nic.Type -ResourceName $nic.Name -Tag @{ CompanyCode = '0322' ; CostElement = 'YCP7300' ; Owneremail = 'cpetricko@chevron.com' ; ProjectName = 'test' ; Owner = 'test' ; EnvName = 'test'} -Force

$adminUsername = 'azureadmin'
$adminPassword = 'Password@1234567'
$cred = New-Object PSCredential $adminUsername, ($adminPassword | ConvertTo-SecureString -AsPlainText -Force)

$vmConfig = New-AzVMConfig -VMName $vmname -VMSize "Standard_DS1_V2" | Set-AzVMOperatingSystem -Linux -ComputerName $vmname -Credential $cred | Set-AzVMSourceImage -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "16.04-LTS" -Version "latest" | Add-AzVMNetworkInterface -Id $nic.Id

New-AzVM -ResourceGroupName "testRG1" -Location $location -VM $vmConfig

Set-AzResource -ResourceGroupName "testRG1" ‑ResourceType $vmname.Type -ResourceName $vmname.Name -Tag @{ CompanyCode = '0322' ; CostElement = 'YCP7300' ; Owneremail = 'cpetricko@chevron.com' ; ProjectName = 'test' ; Owner = 'test' ; EnvName = 'test'} -Force
