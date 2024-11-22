# Please go to the BWS Portal (bwsportal.bioid.com), select your client and click on the key symbol. 
# At the end of the dialog you will find a link “Client Access Token (JWT)”. 
# Click on it and generate a JWT and insert it here.
$jwt = ''

# To specify the endpoint, go to your client in the BWS Portal and select “Update client”. 
# The grpc endpoint is specified there.
$bwsEndpoint = '' # 'https://grpc.xxx-xxx.bioid.com'

$fileName1 = $home + '/live-1.png'
$fileName2 = $home + '/live-2.png'

# Check if the files exist
if (-not (Test-Path $fileName1)) {
    Write-Output "Error: The file '$fileName1' was not found."
    return
}

if (-not (Test-Path $fileName2)) {
    Write-Output "Error: The file '$fileName2' was not found."
    return
}

# Create empty array for liveImages
$liveImages = @()
# Create tag for head movement (relative to first image)
$secondImageTags = @("")

# Create first live image
$liveImage1 = @{
    "image" = [Convert]::ToBase64String([IO.File]::ReadAllBytes($fileName1))
    "tags"  = @("") # empty array
}
# Add to liveImages array
$liveImages += $liveImage1

# Create second live image
$liveImage2 = @{
    "image" = [Convert]::ToBase64String([IO.File]::ReadAllBytes($fileName2))
    "tags"  = $secondImageTags
}
# Add to liveImages array
# $liveImages += $liveImage2


# Fill out the request body and convert to json 
$requestBody = @{ liveImages = $liveImages } | ConvertTo-Json -Depth 3

$response = Invoke-WebRequest -Method POST -Headers @{"Content-Type"="application/json";"Authorization"="Bearer $jwt"} -Body $requestBody -Uri $bwsEndpoint"/api/v1/livenessdetection"
Write-Output "Response: $response"
