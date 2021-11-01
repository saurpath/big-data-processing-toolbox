# Jupyter Notebook
kubctl apply -f jupyter/jupyter-deployment.yaml
kubctl apply -f jupyter/jupyter-service.yaml
kubctl apply -f jupyter/jupyter-lb.yaml

# Hadoop namenode
kubectl apply -f namenode-deployment.yaml
kubectl apply -f namenode-service.yaml
kubectl apply -f namenode-lb.yaml

sleep 10

# Hadoop datanode
kubectl apply -f datanode1-deployment.yaml
kubectl apply -f datanode1-service.yaml
kubectl apply -f datanode2-deployment.yaml
kubectl apply -f datanode2-service.yaml

# Sonarscanner
kubectl apply -f sonarscanner-deployment.yaml
kubectl apply -f sonarscanner-service.yaml
kubectl apply -f sonarscanner-lb.yaml

# Spark Master
kubectl apply -f spark-master-deployment.yaml
kubectl apply -f spark-master-service.yaml
kubectl apply -f spark-master-ingress.yaml

sleep 10

# Spark workers
kubectl apply -f spark-worker1-deployment.yaml
kubectl apply -f spark-worker2-deployment.yaml

