# spark-standalone-cluster
Spark Standalone Cluster With Zookeeper. The docker compose file builds Spark(master/worker) and Zookeeper and starts them

#### How to start:
`docker-compose up`
*Note: Zookeeper and Spark cluster is fixed with two nodes. 
#### How to scale worker:
`docker-compose scale spark-worker=5`
Starts total of 5 spark-worker
