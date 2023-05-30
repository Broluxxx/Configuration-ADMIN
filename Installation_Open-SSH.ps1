# Installation Open-SSH

# Installation de Chocolatey
# Assurez-vous que Get-ExecutionPolicy n'est pas restreint et utilisez Bypass ou AllSigned
# En utilisant Bypass ou AllSigned, vous pouvez contourner les restrictions de politique
# La commande exécute plusieurs actions. Elle définit la politique d'exécution à "Bypass"
# pour le processus en cours, permettant l'exécution de scripts non signés. Ensuite, elle met à jour 
# le protocole de sécurité utilisé par ServicePointManager pour inclure TLS 1.2.
# Enfin, elle télécharge et exécute le script "install.ps1" depuis l'URL spécifiée, 
# qui est un script d'installation de Chocolatey provenant de la communauté.

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Redémarrer l'ordinateur de manière asynchrone
$restartArgs = "-r -t 0"  # Paramètres pour redémarrer immédiatement
Start-Process -FilePath "shutdown.exe" -ArgumentList $restartArgs -NoNewWindow -Wait

# Check Version
ssh -Vssh -V
# Change de dossier
Set-Location "C:\Program Files\OpenSSH-Win64"
# Execute l'nstallation et cinfiguration du script
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1

# Nouvelle règle de pare-feu
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Démarrage OpenSSH - Service
net start sshd
