<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>
$DebugPrefrence = "Continue"
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
remove-item local_users.csv | Out-Null
Function FindSID{
    $DOMAIN = $TextBox1.Text
    $USER = $TextBox2.Text
    if ($CheckBox2.Checked -eq $false){
            $Panel1.Text = net user $USER | out-string
            $Form.Refresh()
    }else{
            $Panel1.Text = net user $USER /domain | out-string
            $Form.Refresh()
    }
    #$objUser = New-Object System.Security.Principal.NTAccount("$DOMAIN, $USER")
    #Write-Host $DOMAIN
    #Write-Host $USER
    #$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
}
Function Export{
        <# This form was created using POSHGUI.com  a free online gui designer for PowerShell
    .NAME
        Untitled
    #>

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $Form.Close()
    $Export                          = New-Object system.Windows.Forms.Form
    $Export.ClientSize               = New-Object System.Drawing.Point(296,120)
    $Export.text                     = "Export"
    $Export.TopMost                  = $false

    $TextBox3                        = New-Object system.Windows.Forms.TextBox
    $TextBox3.multiline              = $false
    $TextBox3.width                  = 292
    $TextBox3.height                 = 20
    $TextBox3.location               = New-Object System.Drawing.Point(0,40)
    $TextBox3.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $TextBox3.Text                   = "Export"

    $Bclose1                         = New-Object system.Windows.Forms.Button
    $Bclose1.text                    = "Close"
    $Bclose1.width                   = 60
    $Bclose1.height                  = 30
    $Bclose1.location                = New-Object System.Drawing.Point(236,88)
    $Bclose1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $Bclose1.Add_Click{
        $Export.Close()
    }

    $BExport                         = New-Object system.Windows.Forms.Button
    $BExport.text                    = "Export"
    $BExport.width                   = 60
    $BExport.height                  = 30
    $BExport.location                = New-Object System.Drawing.Point(0,88)
    $BExport.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $BExport.Add_Click{
        $EXPORTPATH = $TextBox3.Text
        Add-Content -Path .\$EXPORTPATH.txt -value $Panel1.Text
        write-debug "Export Complete"
    }

    $Label1                          = New-Object system.Windows.Forms.Label
    $Label1.text                     = "Enter File Name"
    $Label1.AutoSize                 = $true
    $Label1.width                    = 25
    $Label1.height                   = 10
    $Label1.location                 = New-Object System.Drawing.Point(5,14)
    $Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)    

    $Export.controls.AddRange(@($TextBox3,$Bclose1,$BExport,$Label1))
    $Export.ShowDialog()
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(525,575)
$Form.text                       = "User Information Handler"
$Form.TopMost                    = $false
$Form.FormBorderStyle            = 'Fixed3D'
$Form.maximizeBox                = $false

$closebutton                     = New-Object system.Windows.Forms.Button
$closebutton.text                = "Close"
$closebutton.width               = 60
$closebutton.height              = 30
$closebutton.location            = New-Object System.Drawing.Point(458,545)
$closebutton.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$closebutton.Add_Click{
    $Form.Close()
}


$closebutton2                   = New-Object system.Windows.Forms.Button
$closebutton2.text                = "Export"
$closebutton2.width               = 60
$closebutton2.height              = 30
$closebutton2.location            = New-Object System.Drawing.Point(1,545)
$closebutton2.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$closebutton2.Add_Click{
    Export
}


$Panel1                          = New-Object system.Windows.Forms.TextBox
$Panel1.ReadOnly                 = $true
$Panel1.height                   = 354
$Panel1.width                    = 525
$Panel1.location                 = New-Object System.Drawing.Point(3,180)
$Panel1.MultiLine                = $true
$Panel1.WordWrap                 = $true
$Panel1.Scrollbars               = "Vertical"


$TextBox1                        = New-Object system.Windows.Forms.Label
$TextBox1.text                   = "Enter Username (Used On Login e.g. User) Leave blank for basic list"
$TextBox1.width                  = 460
$TextBox1.height                 = 20
$TextBox1.location               = New-Object System.Drawing.Point(1,42)
$TextBox1.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox2                        = New-Object system.Windows.Forms.TextBox
$TextBox2.multiline              = $false
$TextBox2.text                   = "$env:USERNAME"
$TextBox2.width                  = 408
$TextBox2.height                 = 20
$TextBox2.location               = New-Object System.Drawing.Point(3,72)
$TextBox2.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox5                        = New-Object system.Windows.Forms.TextBox
$TextBox5.multiline              = $false
$TextBox5.text                   = "Domain Users"
$TextBox5.width                  = 408
$TextBox5.height                 = 20
$TextBox5.location               = New-Object System.Drawing.Point(3,120)
$TextBox5.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$GroupLabel = New-Object System.Windows.Forms.Label
$GroupLabel.Text = "Enter Group Name (Domain Checkmark applies)"
$GroupLabel.width = 460
$GroupLabel.Height = 20
$GroupLabel.Location = New-Object System.Drawing.Point(3,100)

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "Find"
$Button3.width                   = 60
$Button3.height                  = 30
$Button3.location                = New-Object System.Drawing.Point(465,120)
$Button3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button3.Add_Click{
    if($CheckBox2.Checked -eq $true){
        $Panel1.Text = net group $TextBox5.Text /domain | Out-String
    }else{
        $Panel1.Text = net localgroup $TextBox5.Text | Out-String
    }
}

$Button4                         = New-Object system.Windows.Forms.Button
$Button4.text                    = "List Groups"
$Button4.width                   = 60
$Button4.height                  = 30
$Button4.location                = New-Object System.Drawing.Point(465,90)
$Button4.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button4.Add_Click{
    if ($checkbox2.Checked -eq $true) {
        $Panel1.Text = net group /domain | out-string
    }else{
        $Panel1.Text = net localgroup | out-string
    }
}

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "User Information GUI"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(5,15)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Find"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(465,62)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.Add_Click{
    FindSID
}

$CheckBox1                       = New-Object system.Windows.Forms.Button
$CheckBox1.text                  = "List Users"
$CheckBox1.AutoSize              = $false
$CheckBox1.width                 = 60
$CheckBox1.height                = 40
$CheckBox1.location              = New-Object System.Drawing.Point(465,30)
$CheckBox1.Add_Click{
    if ($CheckBox2.Checked -eq $true){
        $Panel1.Text = net user /domain
        $Form.Refresh()
    }else{
    Get-WmiObject -ComputerName $env:COMPUTERNAME -Class Win32_UserAccount -Filter "LocalAccount='True'" | Select PSComputername, Name, Status, Disabled, AccountType, Lockout, PasswordRequired, PasswordChangeable, SID | Export-csv .\local_users.csv -noTypeInformation 
    $Panel1.Text = Import-CSV .\local_users.csv |fl | Out-String
    $Form.Refresh()
    }
}
$CheckBox2                       = New-Object system.Windows.Forms.CheckBox
$CheckBox2.text                  = "Domain"
$CheckBox2.AutoSize              = $false
$CheckBox2.width                 = 65
$CheckBox2.height                = 40
$CheckBox2.location              = New-Object System.Drawing.Point(465,1)

$Form.controls.AddRange(@($closebutton,$Panel1,$TextBox1,$TextBox2,$Label1,$Button1,$CheckBox1,$closebutton2,$checkbox2,$TextBox5,$GroupLabel,$Button3,$Button4))
$Form.ShowDialog()