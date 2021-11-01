# Jupyter Notebook
kubectl apply -f jupyter/jupyter-deployment.yaml
kubectl apply -f jupyter/jupyter-service.yaml
kubectl apply -f jupyter/jupyter-lb.yaml

# Hadoop namenode
kubectl apply -f hadoop/namenode/namenode-deployment.yaml
kubectl apply -f hadoop/namenode/namenode-service.yaml
kubectl apply -f hadoop/namenode/namenode-lb.yaml

sleep 10

# Hadoop datanode
kubectl apply -f hadoop/datanode/datanode1-deployment.yaml
kubectl apply -f hadoop/datanode/datanode1-service.yaml
kubectl apply -f hadoop/datanode/datanode2-deployment.yaml
kubectl apply -f hadoop/datanode/datanode2-service.yaml

# Sonarscanner
kubectl apply -f sonarscanner/sonarscanner-deployment.yaml
kubectl apply -f sonarscanner/sonarscanner-service.yaml
kubectl apply -f sonarscanner/sonarscanner-lb.yaml

# Spark Master
kubectl apply -f spark/spark-master-deployment.yaml
kubectl apply -f spark/spark-master-service.yaml
kubectl apply -f spark/spark-master-lb.yaml

sleep 10

# Spark workers
kubectl apply -f spark/spark-worker1-deployment.yaml
kubectl apply -f spark/spark-worker2-deployment.yaml

