# Please go to the BWS Portal (bwsportal.bioid.com), select your client and click on the key symbol. 
# At the end of the dialog you will find a link “Client Access Token (JWT)”. 
# Click on it and generate a JWT and insert it here.
$jwt = ''

# To specify the endpoint, go to your client in the BWS Portal and select “Update client”. 
# The grpc endpoint is specified there.
$bwsEndpoint = '' # 'https://grpc.xxx-xxx.bioid.com'

$fileName =  $home + '/fake.mp4'

if (-not (Test-Path $fileName)) {
    Write-Output "Error: The file '$fileName' was not found."
    return
}

# Encode video to base64 
$base64Video = [Convert]::ToBase64String([IO.File]::ReadAllBytes($fileName));

# Fill out the request body and convert to json 
$requestBody = @{"video"= $base64Video} | ConvertTo-Json

$response = Invoke-WebRequest -Method POST -Headers @{"Content-Type"="application/json";"Authorization"="Bearer $jwt"} -Body $requestBody -Uri $bwsEndpoint"/api/v1/videolivenessdetection"
Write-Output "Response: $response"
