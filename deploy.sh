docker build -t peterprjevara/multi-client:latest -t peterprjevara/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterprjevara/multi-server:latest -t peterprjevara/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peterprjevara/multi-worker:latest -t peterprjevara/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push peterprjevara/multi-client:latest
docker push peterprjevara/multi-client:$SHA

docker push peterprjevara/multi-server:latest
docker push peterprjevara/multi-server:$SHA

docker push peterprjevara/multi-worker:latest
docker push peterprjevara/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=peterprjevara/multi-server:$SHA
kubectl set image deployments/client-deployment client=peterprjevara/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peterprjevara/multi-worker:$SHA

