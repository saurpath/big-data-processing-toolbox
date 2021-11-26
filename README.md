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
    docker build -f Dockerfile -t $DOCKER_USER_ID/sonar-scanner .
    docker push $DOCKER_USER_ID/sonar-scanner
    ```
3. Apache-Spark
    ```ruby
    cd spark/
    docker build -f Dockerfile -t $DOCKER_USER_ID/spark .
    docker push $DOCKER_USER_ID/spark
    ```
4. Driver
    ```ruby
    cd driver/terminal
    docker build -f Dockerfile -t $DOCKER_USER_ID/driver .
    docker push $DOCKER_USER_ID/driver
    ```
4. Driver GUI [Extra Credit]
    ```ruby
    cd driver/
    docker build -f Dockerfile -t $DOCKER_USER_ID/driver-gui .
    docker push $DOCKER_USER_ID/driver-gui
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
    deployment.apps/driver created
    deployment.apps/driver-gui created
    service/driver-lb created
   ```

### 4. Interact using the driver application.
1. Get the pod ID for the driver.
  ```ruby
    saurpath95@cloudshell:~/big-data-processing-toolbox (test-330723)$ kubectl get pods
    NAME                                READY   STATUS    RESTARTS   AGE
    datanode1-549b879ff6-f5mqr          1/1     Running   0          22m
    datanode2-7f646fc575-zg26d          1/1     Running   0          22m
    driver-6f9db4d7-zp9nd               1/1     Running   0          22m
    driver-gui-58655868fd-9qx6j         1/1     Running   0          22m
    jupyter-notebook-78987c94c7-wxqrd   1/1     Running   0          22m
    namenode-7db54bb467-99m24           1/1     Running   0          22m
    sonar-scanner-d6f477d89-jkrvf       1/1     Running   0          22m
    spark-master-7f6569fbf5-pq68t       1/1     Running   0          22m
    spark-worker1-5bb68bd769-gh549      1/1     Running   0          22m
    spark-worker1-5bb68bd769-zx954      1/1     Running   0          22m
    spark-worker2-b9bb944c-gmtmz        1/1     Running   0          22m
    spark-worker2-b9bb944c-gzkmc        1/1     Running   0          22m
  ```
2. Run the file in interactive mode.
   Note: The driver currently only acts as a landing page. Links to each micro-service will be updated soon.
  ```ruby
    saurpath95@cloudshell:~/big-data-processing-toolbox (test-330723)$ kubectl exec -it driver-6f9db4d7-zp9nd -- python3 toolbox.py

    Welcome to Big Data Processing Application


    Please type number that corresponds to which application you would like to run:
    1. Apache Hadoop
    2. Apache Spark
    3. Jupyter Notebook
    4. SonarQube and SonarScanner
    5. Exit


    Type the number the here > 1
    Navigate to: http://34.121.62.89

    Please type number that corresponds to which application you would like to run:
    1. Apache Hadoop
    2. Apache Spark
    3. Jupyter Notebook
    4. SonarQube and SonarScanner
    5. Exit


    Type the number the here > 2
    Navigate to: http://34.135.128.145

    Please type number that corresponds to which application you would like to run:
    1. Apache Hadoop
    2. Apache Spark
    3. Jupyter Notebook
    4. SonarQube and SonarScanner
    5. Exit


    Type the number the here > 3
    Navigate to: http://34.134.205.190

    Please type number that corresponds to which application you would like to run:
    1. Apache Hadoop
    2. Apache Spark
    3. Jupyter Notebook
    4. SonarQube and SonarScanner
    5. Exit


    Type the number the here > 4
    Navigate to: http://34.133.164.88

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

13. [Extra Credit] Driver GUI

![SonarQube](/Images/driver.png)

----------
### Container Images on Docker Hub.
1. Driver: https://hub.docker.com/r/saurpath/driver
2. [Extra Credit] Driver GUI: https://hub.docker.com/r/saurpath/driver-gui
3. Apache-Hadoop Master: https://hub.docker.com/r/saurpath/hadoop-master
4. Apache-Hadoop Worker: https://hub.docker.com/r/saurpath/hadoop-worker
5. Sonar-Scanner: https://hub.docker.com/r/saurpath/sonar-scanner
6. Apache-Spark: https://hub.docker.com/r/saurpath/spark
7. Jupyter: https://hub.docker.com/r/jupyter/minimal-notebook
----------
