docker build -t 1man/multi-client:latest -t 1man/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t 1man/multi-server:latest -t 1man/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t 1man/multi-worker:latest -t 1man/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push 1man/multi-client:latest
docker push 1man/multi-server:latest
docker push 1man/multi-worker:latest

docker push 1man/multi-client:$SHA
docker push 1man/multi-server:$SHA
docker push 1man/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=1man/multi-server:$SHA
kubectl set image deployments/client-deployment client=1man/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=1man/multi-worker:$SHA