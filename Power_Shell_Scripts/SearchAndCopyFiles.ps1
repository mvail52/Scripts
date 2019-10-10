$location = Read-Host 'What is the location you would like to search?'
$destination =  Read-Host 'What is destination you would files copied to?'
$search = Read-Host 'Enter the of the item'

Set-Location  $location.ToString()

foreach( $e in Get-ChildItem -Path $location -Name -Recurse)
    {

    if ($e.ToString() -like "*$search*")
        {
            $name = Split-Path(Split-Path "$e") -leaf
            $dest = $destination+ "\" + $name.ToString()

            Copy-Item "$e" -Destination $dest
            #if you want to see the files it is copying then uncomment the next line
            #Write-Output "Copied " + $e.ToString()
        }
    }