gcloud projects create saurpath-toolbox-demo --set-as-default
gcloud services enable container.googleapis.com
gcloud config set compute/zone us-central1-c 
gcloud container clusters create toolbox --num-nodes=3
gcloud container clusters get-credentials  --region=us-central1-c toolbox