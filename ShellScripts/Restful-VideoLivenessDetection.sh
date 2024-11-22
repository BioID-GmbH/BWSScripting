#!/usr/bin/env bash

# Please go to the BWS Portal (bwsportal.bioid.com), select your client and click on the key symbol. 
# At the end of the dialog you will find a link “Client Access Token (JWT)”. 
# Click on it and generate a JWT and insert it here.
jwt=""

# To specify the endpoint, go to your client in the BWS Portal and select “Update client”. 
# The grpc endpoint is specified there.
bwsEndpoint=""  # 'https://grpc.xxx-xxx.bioid.com'

# Paths to your images
fileName="$HOME/fake.mp4"

# Check if the image files exist
if [ ! -f "$fileName" ]; then
  echo "Error: The video file $fileName do not exist in the path."
  exit 1
fi

# Convert video to Base64 (remove newlines)
video=$(base64 "$fileName" | tr -d '\n')


# Manually construct the JSON payload and write it to a temporary file
jsonPayload=$(mktemp)

cat <<EOF > "$jsonPayload"
{
  "video": "$video"
}
EOF

# Use curl with --data-binary to avoid "Argument list too long" issue
response=$(curl -s -X POST "$bwsEndpoint/api/v1/videolivenessdetection" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $jwt" \
  --data-binary @"$jsonPayload")

# Check if the response is successful
if [ $? -eq 0 ]; then
  echo "API request sent successfully!"
else
  echo "Error: Failed to send the API request."
  exit 1
fi

# Output the response
echo "Response: $response"

# Clean up the temporary file
rm -f "$jsonPayload"