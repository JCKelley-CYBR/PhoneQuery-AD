# PhoneQuery-AD

## Description
This script queries Active Directory for users based on a phone number. It will return the queried number, Name, SamAccountName, telephoneNumber, title, and Company.

## Requirements
* PowerShell 5.0 or higher
  * May or may not work on PowerShell 4.0 or lower.
* [ActiveDirectory Module](https://docs.microsoft.com/en-us/powershell/module/addsadministration/?view=win10-ps)
    * `PS> Install-Module -Name ActiveDirectory`

## Installation
* `git clone https://github.com/JCKelley-CYBR/PhoneQuery-AD.git`
* Download the ZIP file from the [HERE](https://github.com/JCKelley-CYBR/PhoneQuery-AD/archive/refs/heads/main.zip) and extract the contents.

## Usage
```powershell
PS C:\> .\PhoneQuery-AD.ps1 -path <path to CSV file> -o <output file name> -fieldname <name of the field containing the phone numbers>
```

## Example
```powershell
PS C:\> .\PhoneQuery-AD.ps1 -path .\phone_numbers.csv -o output.csv -fieldname "Phone Number"
```