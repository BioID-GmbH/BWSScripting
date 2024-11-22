# BWSScripting
This repository contains scripts for the interaction with the BioID Web Services (BWS 3) RESTful JSON API for Passive and Active Liveness Detection, Video Liveness Detection and photo ID verification (PhotoVerify).

## Features
- **Liveness Detection:** Submit images for liveness detection to ensure that the image is of a “real” person in front of the camera.
- **Video Liveness Detection:** Performs face liveness detection on a video.
- **Photo Verify:** PhotoVerify is a service, which uses one photo, e.g. a passport image from an ID document, and compares that to one or two "live" images of a person, to find out whether the persons shown are the same.
- **JWT Authentication:** The scripts use JSON Web Tokens (JWT) for secure API access to BioID Web Service (BWS 3).
- **Flexible Integration**: The scripts can be modified to suit different use cases.

> ### Before starting, follow these steps
>
> - You need a **BioID Account** with a **confirmed** email address. If you don’t have one, [create a BioID account][bioidaccountregister].
> - You can create a free [trial subscription][trial] of the BioID Web Service (BWS 3) once you've created your BioID account.
> - After you have signed in to the BWS Portal and created the trial subscription with the help of a wizard, you still need to create a ***BWS 3 client***.
> - The client can be created with the help of a creation wizard.

## Prerequisites
To use the scripts in this repository, you will need:
1. **Client Access Token (JWT)**:
   - Log in to the [BWS Portal][bwsportal]
   - Select your client, click on the key symbol, and generate a **Client Access Token (JWT)** for authenticating API requests.
3. **BWS gRPC Endpoint URL**: To specify the endpoint, go to your client in the BWS Portal and select “Update client”. 
4. **Images or Video**: You will need image files to use with the API (e.g., live-1.png, live-2.png) for liveness detection. Please test our media files first.

## More technical information about
- [**Liveness Detection**][liveness]
- [**Video Liveness Detection**][videoliveness]
- [**PhotoVerify**][photoverify]

[bioidaccountregister]: https://account.bioid.com/Account/Register "Register a BioID account"
[trial]: https://bwsportal.bioid.com/ "Create a free trial subscription"
[bwsportal]: https://bwsportal.bioid.com "BWS Portal"
[liveness]: https://developer.bioid.com/bws/restful/livenessdetection/ "Presentation attack detection."
[photoverify]: https://developer.bioid.com/bws/restful/photoverify/ "PhotoVerify"
[videoliveness]: https://developer.bioid.com/bws/restful/videolivenessdetection/ "Presentation attack detection in videos."
