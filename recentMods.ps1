param (
    [int]$number
)

if ( -not $number) {$number = 1}
# write-host $number
$newNumber = ($number * -1)
$TARGETDATE = (Get-Date).AddDays($newNumber)
write-host "Looking for files modified since $TARGETDATE"
 
# if ( $number > 0 ) { 
# write-host "$newNumber"

$pattern = 'FaceCollection|Applications|Music|Movies|Photos Library\.photoslibrary|AudioBooks|Microsd32|fromCD|\.vscode'

Get-ChildItem -File -Recurse |
    Where-Object {
        $_.LastWriteTime -gt $TARGETDATE -and
        $_.FullName -notmatch $pattern
    } |
    ForEach-Object { dir $_.FullName }

write-host "Files modified since $TARGETDATE"
