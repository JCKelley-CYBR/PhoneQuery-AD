###################
# Get-ADUsers-PhoneNumbers-List.ps1
# Author: Joshua C. Kelley
# Version: 1.0
# Date: 2023-03-13
# Description: This script will take in a list of phone numbers, and return a list of users associated with those phone numbers in Active Directory
###################

param (
    [Parameter(Mandatory=$true)]
    [string]$path,
    [Parameter(Mandatory=$true)]
    [string]$fieldname,
    [Parameter(Mandatory=$true)]
    [string]$O
)
# Global variables
$importdata = Import-Csv -Path $path
$ErrorActionPreference= 'silentlycontinue'

# function to parse the phone number

# Main
Invoke-Command -ScriptBlock {
    $exportdata = @()
    foreach ($row in $importdata) {
        $recipient = $row.$fieldname
        $temp = "*$recipient*"
        $recipientAD = Get-ADUser -Filter {telephoneNumber -like $temp} -Properties telephoneNumber, title, Company | Select-Object SamAccountName, Name, telephoneNumber, title, Company
        Write-Output $recipientAD
        $data = New-Object System.Object
        $data | Add-Member -MemberType NoteProperty -Name "Recipient_Number" -Value $recipient
        $data | ADD-Member -MemberType NoteProperty -Name "Recipient_Name" -Value $recipientAD.Name
        $data | Add-Member -MemberType NoteProperty -Name "Recipient_ZID" -Value $recipientAD.SamAccountName
        $data | Add-Member -MemberType NoteProperty -Name "Recipient_Phone" -Value $recipientAD.telephoneNumber
        $data | Add-Member -MemberType NoteProperty -Name "Recipient_Title" -Value $recipientAD.title
        $data | Add-Member -MemberType NoteProperty -Name "Recipient_Company" -Value $recipientAD.Company

        $exportdata += $data

    }

    $exportdata | Export-Csv -Path "$pwd\$O" -NoTypeInformation
}