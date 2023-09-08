# Restore-DeletedMailbox

## 📄 Description

Ce script est conçu pour restaurer une boîte aux lettres supprimée dans Exchange Online. Il installe automatiquement le module ExchangeOnlineManagement si nécessaire, se connecte à Exchange Online, restaure la boîte aux lettres supprimée, puis se déconnecte.

## 🔍 Prérequis

- **PowerShell** : v5.1 ou supérieur.
- **Droits administratifs** : Nécessaires pour restaurer les boîtes aux lettres dans Exchange Online.

## 📥 Installation

1. Assurez-vous d'avoir les prérequis mentionnés ci-dessus.
2. Téléchargez le script `Restore-DeletedMailbox.ps1` dans votre répertoire de travail.
3. Si nécessaire, modifiez le script pour correspondre à vos besoins spécifiques.

## 🚀 Utilisation

Pour exécuter le script, ouvrez PowerShell et naviguez vers le répertoire où se trouve le script. Exécutez la commande suivante :

```powershell
.\Restore-DeletedMailbox.ps1 -UserPrincipalName [Votre_UPN] -SoftDeletedObject [Votre_SoftDeletedObject]
