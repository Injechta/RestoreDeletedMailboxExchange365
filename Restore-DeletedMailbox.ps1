<#
.SYNOPSIS
Script pour restaurer une boîte aux lettres supprimée dans Exchange Online.
.DESCRIPTION
Ce script installe le module ExchangeOnlineManagement (si nécessaire), se connecte à Exchange Online,
restaure une boîte aux lettres supprimée et se déconnecte d'Exchange Online.
.PARAMETER UserPrincipalName
Le UserPrincipalName pour la connexion à Exchange Online.
.PARAMETER SoftDeletedObject
La boîte aux lettres supprimée à restaurer.
.EXAMPLE
.\scriptname.ps1 -UserPrincipalName user1987@ga.fr -SoftDeletedObject SR12
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$UserPrincipalName,

    [Parameter(Mandatory=$true)]
    [string]$SoftDeletedObject
)

function Install-ExchangeOnlineModule {
    if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
        Install-Module -Name ExchangeOnlineManagement -AllowClobber -Scope CurrentUser -Force
        Write-Output "Module ExchangeOnlineManagement installé."
    }
    Import-Module ExchangeOnlineManagement
}

function Connect-ToExchangeOnline {
    param (
        [string]$UPN
    )
    $connection = Connect-ExchangeOnline -UserPrincipalName $UPN -ErrorAction SilentlyContinue
    if (-not $connection) {
        throw "Erreur lors de la connexion à Exchange Online avec l'UPN $UPN."
    }
    Write-Output "Connecté à Exchange Online avec l'UPN $UPN."
}

Install-ExchangeOnlineModule

try {
    Connect-ToExchangeOnline -UPN $UserPrincipalName

    # Restauration de la boîte aux lettres
    Undo-SoftDeletedMailbox -SoftDeletedObject $SoftDeletedObject

    # Information sur la réussite de l'opération
    Write-Output "La boîte aux lettres $SoftDeletedObject a été restaurée."

} catch {
    Write-Error "Une erreur est survenue : $_"
} finally {
    # Déconnexion de Exchange Online
    Disconnect-ExchangeOnline -Confirm:$false
    Write-Output "Déconnecté de Exchange Online."
}
