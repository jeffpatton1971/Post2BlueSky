param (
 [string]$Message,
 [string]$Link
)
try
{
 $ErrorActionPreference = 'Stop';
 $Error.Clear();

 $verbose = $env:VERBOSE
 $Identifier = $env:BLUESKY_IDENTIFIER
 $ApiKey = $env:BLUESKY_API_KEY

 $baseUri = 'https://bsky.social'
 $protocol = 'xrpc'
 $createSession = 'com.atproto.server.createSession'
 $createRecord = 'com.atproto.repo.createRecord'

 $CreateSessionUri = "$($baseUri)/$($protocol)/$($createSession)"
 $CreateRecordUri = "$($baseUri)/$($protocol)/$($createRecord)"

 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "Post2BlueSkey DEBUG"
  Write-Host "CreateSessionUri : $($CreateSessionUri)"
  Write-Host "CreateRecordUri  : $($CreateRecordUri)"
  Write-Host "Message          : $($Message)"
 }

 $AuthBody = @{'identifier' = $Identifier; 'password' = $ApiKey }
 $Headers = @{}
 $Headers.Add('Content-Type', 'application/json')

 $Response = Invoke-RestMethod -Uri $CreateSessionUri -Method Post -Body ($AuthBody | ConvertTo-Json -Compress) -Headers $Headers
 $Headers.Add('Authorization', "Bearer $($Response.accessJwt)")

 $createdAt = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.ffffffZ"

 $Record = New-Object -TypeName psobject -Property @{
  '$type'     = "app.bsky.feed.post"
  'text'      = $Message
  "createdAt" = $createdAt
 }

 if ($Links)
 {
  $embeds = @()
  foreach ($uri in $Link.Split(','))
  {
   $embeds += New-Object -TypeName psobject -Property @{
    '$type' = 'app.bsky.embed.link'
    'url'   = $uri
   }
  }
  $Post = New-Object -TypeName psobject -Property @{
   'repo'       = $Identifier
   'collection' = 'app.bsky.feed.post'
   record       = $Record
   embeds       = $embeds
  }
 }
 else
 {
  $Post = New-Object -TypeName psobject -Property @{
   'repo'       = $Identifier
   'collection' = 'app.bsky.feed.post'
   record       = $Record
  }
 }

 Invoke-RestMethod -Uri $CreateRecordUri -Method Post -Body ($Post | ConvertTo-Json -Depth 10 -Compress) -Headers $Headers
}
catch
{
 $_.InvocationInfo | Out-String;
 throw $_.Exception.Message;
}