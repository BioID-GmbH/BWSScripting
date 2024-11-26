import base64
import json
import os
# To install the required library: https://pypi.org/project/requests/
# pip install requests
import requests

# Please go to the BWS Portal (bwsportal.bioid.com), select your client and click on the key symbol. 
# At the end of the dialog you will find a link "Client Access Token (JWT)". 
# Click on it and generate a JWT and insert it here.
jwt = ""

# To specify the endpoint, go to your client in the BWS Portal and select "Update client". 
# The grpc endpoint is specified there.
bws_endpoint = ""  # Example: 'https://grpc.xxx-xxx.bioid.com'

# Path to the video file
file_name = os.path.expanduser("~/fake.mp4")

# Check if the video file exists
if not os.path.isfile(file_name):
    print("Error: The video file does not exist in the path {}.".format(os.path.expanduser('~')))
    exit(1)

# Function to encode the video to Base64
def encode_video(file_path):
    with open(file_path, "rb") as video_file:
        return base64.b64encode(video_file.read()).decode('utf-8')

# Encode the video
video = encode_video(file_name)

# Create the JSON payload
payload = {
    "video": video
}

# Headers for the request
headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer {}".format(jwt)
}

# Send the API request
response = requests.post("{}/api/v1/videolivenessdetection".format(bws_endpoint), json=payload, headers=headers)

# Check if the response was successful
if response.status_code == 200:
    print("API request successfully sent!")
else:
    print("Error: Request failed with status code {}".format(response.status_code))
    print("Response: {}".format(response.text))
    exit(1)

# Print the response
print("Response:", response.json())
