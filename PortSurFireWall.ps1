$Connexion = Read-Host "Connexion UDP ou TCP ? (U/T)"
if($Connexion -eq "T") {
    Write-Host "Veuiller indiquer le numero de port a activer"
    $valeur = Read-Host
    Write-Host "Activation du port : $valeur"
    New-NetFirewallRule -DisplayName "ALLOW TCP PORT $valeur" -Direction Inbound -Protocol TCP -LocalPort $valeur -Action Allow
    $reponse = Read-Host "Voulez-vous vérifier la règle du pare-feu ? (Oui/Non)"
    if ($reponse -eq "Oui") {
        $rule = "ALLOW TCP PORT $valeur"
        Get-NetFirewallRule -DisplayName $rule | Format-Table -Property Name, DisplayName, @{Name='Protocol';Expression={($PSItem | Get-NetFirewallPortFilter).Protocol}}, @{Name='LocalPort';Expression={($PSItem | Get-NetFirewallPortFilter).LocalPort}}, @{Name='RemotePort';Expression={($PSItem | Get-NetFirewallPortFilter).RemotePort}}, @{Name='RemoteAddress';Expression={($PSItem | Get-NetFirewallAddressFilter).RemoteAddress}}, Enabled, Profile, Direction, Action
    }       
    else {
        exit
    }
}
elseif($Connexion -eq "U"){
    Write-Host "Veuiller indiquer le numero de port a activer"
    $valeur = Read-Host
    Write-Host "Activation du port : $valeur"
    New-NetFirewallRule -DisplayName "ALLOW UDP PORT $valeur" -Direction Inbound -Protocol UDP -LocalPort $valeur -Action Allow
    $reponse = Read-Host "Voulez-vous vérifier la règle du pare-feu ? (Oui/Non)"
    if ($reponse -eq "Oui") {
        $rule = "ALLOW UDP PORT $valeur"
        Get-NetFirewallRule -DisplayName $rule | Format-Table -Property Name, DisplayName, @{Name='Protocol';Expression={($PSItem | Get-NetFirewallPortFilter).Protocol}}, @{Name='LocalPort';Expression={($PSItem | Get-NetFirewallPortFilter).LocalPort}}, @{Name='RemotePort';Expression={($PSItem | Get-NetFirewallPortFilter).RemotePort}}, @{Name='RemoteAddress';Expression={($PSItem | Get-NetFirewallAddressFilter).RemoteAddress}}, Enabled, Profile, Direction, Action
    } else {
        exit
    }
}
else{
    exit
}
