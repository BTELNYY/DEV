<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$cd = Split-Path $script:MyInvocation.MyCommand.Path
Function OpenFile(){
	# Creates a Explorer Open File Dialog
	# RETURNS FILTERED PATH
	$myFile = "$cd"
	[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	$OpenFileDialog.InitialDirectory = Split-Path $myFile -Parent 
	$OpenFileDialog.FileName = Split-path $myfile -leaf
    $OpenFileDialog.ShowDialog() | Out-Null
    Read-DAT
    return $OpenFileDialog.FileName
    
}
function Read-DAT {
    $FilePath = $OpenFileDialog.FileName
	# read the binary data as byte array
	$bytes = [System.IO.File]::ReadAllBytes("$FilePath")
	# convert to ASCII string
	$text = [System.Text.Encoding]::ASCII.GetString($bytes)
   
	# replace the CRLF to LF
	$text = $text -replace "`r`n", "`n"
   
	# convert back to byte array
	$bytes = [System.Text.Encoding]::ASCII.GetBytes($text)
    # show the results
    if ($checkbox.checked -eq $true){
        $Panel1.text = "$text"
        $Form.Refresh()
    }else{
        $Panel1.text                     = "$bytes, $text"
        $Form.Refresh()
    }
}

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(447,400)
$Form.text                       = "Read-File"
$Form.TopMost                    = $false
$Form.FormBorderStyle           = 'Fixed3D'
$Form.maximizeBox               = $false

$Checkbox                        = New-Object system.Windows.Forms.CheckBox
$Checkbox.text                   = "Read ASCII Only"
$Checkbox.AutoSize               = $false
$Checkbox.width                  = 200
$Checkbox.height                 = 20
$Checkbox.location               = New-Object System.Drawing.Point(11,365)
$Checkbox.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LinkLabel1 = New-Object System.Windows.Forms.LinkLabel
$LinkLabel1.Location = New-Object System.Drawing.Size(150,368)
$LinkLabel1.Size = New-Object System.Drawing.Size(150,20)
$LinkLabel1.LinkColor = "BLUE"
$LinkLabel1.ActiveLinkColor = "RED"
$LinkLabel1.Text = "Whats ASCII?"
$LinkLabel1.add_Click({[system.Diagnostics.Process]::start("https://en.wikipedia.org/wiki/ASCII")})
$Form.Controls.Add($LinkLabel1) 



$Panel1                          = New-Object system.Windows.Forms.TextBox
$Panel1.AutoSize                 = $true 
$Panel1.MultiLine                = $true
$Panel1.Enabled                  = $true
$Panel1.Scrollbars               = "Vertical"
$Panel1.ReadOnly                 = $true
$Panel1.height                   = 314
$Panel1.width                    = 440
$Panel1.location                 = New-Object System.Drawing.Point(4,35)


$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Close"
$Button1.width                   = 60
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(380,360)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button1.Add_Click{
    $Form.Close()
}

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Open File"
$Button2.width                   = 80
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(305,360)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$Button2.Add_Click{
    OpenFile
}

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Binary File Reader and Transcript to ASCII"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(7,10)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($Panel1,$Button1,$Label1,$Button2,$Checkbox))
$Form.ShowDialog()