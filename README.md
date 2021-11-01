# Big Data Processing Toolbox
###### Author: Saurabh Pathak (spathak2@andrew.cmu.edu)

### Summary
This is a microservice-based application that would allow the users to run Apache Hadoop, Spark, Jupyter Notebooks, SonarQube and SonarScanner without having to install any of them.

![Application overview](/Images/overview.png)

### Steps Required:
- Deploy the images to DockerHub.
- Setup Google Cloud Environment.
- Deploy the applications to GKE.
- Interact using the driver application.

## Detailed steps:

### 1.  Build docker container images for each microservice and push them to DockerHub.
1. Setup docker environment
    ```ruby
    export DOCKER_USER_ID=saurpath
    docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
    ```
2. Apache-Hadoop
    ```ruby
    cd hadoop/namenode
    docker build -f Dockerfile -t $DOCKER_USER_ID/hadoop-master .
    docker push $DOCKER_USER_ID/hadoop-master
    
    cd ../datanode
    docker build -f Dockerfile -t $DOCKER_USER_ID/hadoop-worker .
    docker push $DOCKER_USER_ID/hadoop-worker
    ```
3. SonarScanner
    ```ruby
    cd sonarscanner/
    docker build -f Dockerfile -t $DOCKER_USER_ID/sonar-scanner.
    docker push $DOCKER_USER_ID/sonar-scanner
    ```
3. Apache-Spark
    ```ruby
    cd spark/
    docker build -f Dockerfile -t $DOCKER_USER_ID/spark.
    docker push $DOCKER_USER_ID/spark
    ```
4. Driver
```ruby
cd driver/
docker build -f Dockerfile -t $DOCKER_USER_ID/driver.
docker push $DOCKER_USER_ID/driver
```

### 2. Setup Google Cloud Environment.
1. Create a new project.
2. Enable Kubernetes API for the project.
3. Open Cloud Shell and ensure that the shell is tied to the correct project.
   ```ruby
   gcloud config set project $PROJECT_ID
   ```
5. Create a new cluster named  ```toolbox```
   Note: This might take some time. Wait for it complete before proceeding forward.
   ```ruby
   gcloud container clusters create toolbox --region=us-central1-c
   ```
5. Bind the shell to the cluster.
   ```ruby
    gcloud container clusters get-credentials  --region=us-central1-c toolbox
   ```

### 3. Deploy microservices on GKE.
1. Clone this github repo locally to access the resource manifests.
   ```ruby
    git clone https://github.com/saurpath/big-data-processing-toolbox
   ```
2. Navigate to the folder and ensure the shell is binded to the correct cluster.
   ```ruby
    cd big-data-processing-toolbox
    gcloud container clusters get-credentials  --region=us-central1-c toolbox
   ```
4. Make the shell script executable and run the same.
   ```ruby
    chmod +x deploy-everything.sh && ./deploy-everything.sh
   ```
5. All the pods, services and load-balancers will be created for you automatically.
   ```ruby
    saurpath95@cloudshell:~/big-data-processing-toolbox (test-330723)$ chmod +x deploy-everything.sh && ./deploy-everything.sh
    deployment.apps/jupyter-notebook created
    service/jupyter-notebook created
    service/jupyter-notebook-lb created
    deployment.apps/namenode created
    service/namenode created
    service/namenode-lb created
    deployment.apps/datanode1 created
    service/datanode1 created
    deployment.apps/datanode2 created
    service/datanode2 created
    deployment.apps/sonar-scanner created
    service/sonar-scanner created
    service/sonar-scanner-lb created
    deployment.apps/spark-master created
    service/spark-master created
    service/spark-master-lb created
    deployment.apps/spark-worker1 created
    deployment.apps/spark-worker2 created
   ```

### 4. Interact using the driver application.
1. Pull the driver docker image.
  ```ruby
  docker pull saurpath/driver
  ```
2. Run the file in interactive mode.
   Note: The driver currently only acts as a landing page. Links to each micro-service will be updated soon.
  ```ruby
  saurpath95@cloudshell:~/big-data-processing-toolbox (test-330723)$ docker run -it saurpath/driver

  Welcome to Big Data Processing Application


  Please type number that corresponds to which application you would like to run:
  1. Apache Hadoop
  2. Apache Spark
  3. Jupyter Notebook
  4. SonarQube and SonarScanner
  5. Exit


  Type the number the here > 1
  TODO: Link Apache Hadoop Here

  Please type number that corresponds to which application you would like to run:
  1. Apache Hadoop
  2. Apache Spark
  3. Jupyter Notebook
  4. SonarQube and SonarScanner
  5. Exit


  Type the number the here > 2
  TODO: Link Apache Spark Here

  Please type number that corresponds to which application you would like to run:
  1. Apache Hadoop
  2. Apache Spark
  3. Jupyter Notebook
  4. SonarQube and SonarScanner
  5. Exit


  Type the number the here > 3
  TODO: Link Jupyter Notebook Here

  Please type number that corresponds to which application you would like to run:
  1. Apache Hadoop
  2. Apache Spark
  3. Jupyter Notebook
  4. SonarQube and SonarScanner
  5. Exit


  Type the number the here > 4
  TODO: Link Sonarqube Here

  Please type number that corresponds to which application you would like to run:
  1. Apache Hadoop
  2. Apache Spark
  3. Jupyter Notebook
  4. SonarQube and SonarScanner
  5. Exit


  Type the number the here > 5
  Thank you for using Big Data Processing Application.
  ```

## Sample Output from GKE!
1. Cluster

![Cluster](/Images/cluster.png)

2. Pods

![Pods](/Images/pods.png)

3. Services and Load-Balancers
 
![Services and Load-Balancers](/Images/services.png)

7. Apache-Hadoop

![Apache-Hadoop](/Images/apache-hadoop.png)

9. Jupyter

![Jupyter](/Images/jupyter.png)

11. Apache-Spark

![Spark](/Images/spark.png)

13. SonarQube

![SonarQube](/Images/sonarqube.png)

----------
### Container Images on Docker Hub.
1. Driver: https://hub.docker.com/r/saurpath/driver
2. Apache-Hadoop Master: https://hub.docker.com/r/saurpath/hadoop-master
3. Apache-Hadoop Worker: https://hub.docker.com/r/saurpath/hadoop-worker
4. Sonar-Scanner: https://hub.docker.com/r/saurpath/sonar-scanner
5. Apache-Spark: https://hub.docker.com/r/saurpath/spark
6. Jupyter: https://hub.docker.com/r/jupyter/minimal-notebook
----------
