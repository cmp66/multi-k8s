docker build -t wahoo66/multi-client:latest -t wahoo66/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t wahoo66/multi-server:latest -t wahoo66/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t wahoo66/multi-worker:latest -t wahoo66/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push wahoo66/multi-client:latest
docker push wahoo66/multi-server:latest
docker push wahoo66/multi-worker:latest

docker push wahoo66/multi-client:$GIT_SHA
docker push wahoo66/multi-server:$GIT_SHA
docker push wahoo66/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wahoo66/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=wahoo66/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=wahoo66/multi-worker:$GIT_SHA