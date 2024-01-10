param (
 [string]$Source,
 [string]$ProjectName,
 [string]$Identifier,
 [string]$Password
)
try
{
 $ErrorActionPreference = 'Stop';
 $Error.Clear();

 $SourcePath = Get-Item -Path $Source;
 $GitHubRepoUrl = "https://github.com/$($env:GITHUB_REPOSITORY)"

 $AuthBody = @{'identifier' = $Identifier; 'password' = $Password }
 $Headers = @{}
 $Headers.Add('Content-Type', 'application/json')
 $Response = Invoke-RestMethod -Uri "https://bsky.social/xrpc/com.atproto.server.createSession" -Method Post -Body ($AuthBody | ConvertTo-Json -Compress) -Headers $Headers
 $Headers.Add('Authorization', "Bearer $($Response.accessJwt)")
 
 $embeds = @()
 $embeds += New-Object -TypeName psobject -Property @{
  '$type'       = 'app.bsky.embed.link'
  'url'         = $GitHubRepoUrl
  'title'       = "Github.com $($script:ProjectName)"
  'description' = $project.Project.PropertyGroup.Description
 }

 if (Test-Path -Path $SourcePath)
 {
  switch ($SourcePath.Extension)
  {
   ".psd1"
   {
    $Module = Import-PowerShellDataFile -Path $SourcePath
    $Version = $Module.ModuleVersion
    $PowerShellGalleryUrl = "https://www.powershellgallery.com/packages/$($ProjectName)"
    $Text = "Version $Version of $($ProjectName) released. Please visit Github ($($GitHubRepoUrl)) or PowerShellGallery.com ($($PowerShellGalleryUrl)) to download."
    $embeds += New-Object -TypeName psobject -Property @{
     '$type'       = 'app.bsky.embed.link'
     'url'         = $PowerShellGalleryUrl
     'title'       = "Nuget.org $($script:ProjectName)"
     'description' = $project.Project.PropertyGroup.Description
    }
   }
   ".csproj"
   {
    $Project = [xml](Get-Content -Path $SourcePath);
    $Version = $Project.Project.PropertyGroup.Version.ToString();
    $PackageId = $Project.Project.PropertyGroup.PackageId;
    $NugetUrl = "https://nuget.org/packages/$PackageId"
    $Text = "Version $Version of $($ProjectName) released. Please visit Github ($($GitHubRepoUrl)) or Nuget.org ($($NugetUrl)) to download."
    $embeds += New-Object -TypeName psobject -Property @{
     '$type'       = 'app.bsky.embed.link'
     'url'         = $NugetUrl
     'title'       = "Nuget.org $($script:ProjectName)"
     'description' = $project.Project.PropertyGroup.Description
    }
   }
  }
  $createdAt = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.ffffffZ"
  $Record = New-Object -TypeName psobject -Property @{
   '$type'     = "app.bsky.feed.post"
   'text'      = $Text
   "createdAt" = $createdAt
  }
  $Post = New-Object -TypeName psobject -Property @{
   'repo'       = $Handle
   'collection' = 'app.bsky.feed.post'
   record       = $Record
   embeds       = $embeds
  }

  Invoke-RestMethod -Uri "https://bsky.social/xrpc/com.atproto.repo.createRecord" -Method Post -Body ($Post | ConvertTo-Json -Compress) -Headers $Headers
 }
}
catch
{
 Write-Host "Error occurred: $($_.Exception.Message)"
}