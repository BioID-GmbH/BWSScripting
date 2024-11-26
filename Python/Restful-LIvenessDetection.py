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

# Paths to the image files
file_name1 = os.path.expanduser("~/live-1.png")
file_name2 = os.path.expanduser("~/live-2.png")

# Check if the image files exist
if not os.path.isfile(file_name1) or not os.path.isfile(file_name2):
    print("Error: One or both image files do not exist in the path {}.".format(os.path.expanduser('~')))
    exit(1)

# Function to encode images to Base64
def encode_image(file_path):
    with open(file_path, "rb") as image_file:
        return base64.b64encode(image_file.read()).decode('utf-8')

image1 = encode_image(file_name1)
image2 = encode_image(file_name2)

# Manually create the JSON payload
payload = {
    "liveImages": [
        {
            "image": image1,
            "tags": []
        },
        {
            "image": image2,
            "tags": []
        }
    ]
}

# Headers for the request
headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer {}".format(jwt)
}

# Send the API request
response = requests.post("{}/api/v1/livenessdetection".format(bws_endpoint), json=payload, headers=headers)

# Check if the response was successful
if response.status_code == 200:
    print("API request successfully sent!")
else:
    print("Error: Request failed with status code {}".format(response.status_code))
    print("Response: {}".format(response.text))
    exit(1)

# Print the response
print("Response: ", response.json())
