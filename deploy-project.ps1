# Deploy the project to Minikube

# Get Docker Hub username (no caso: marioltf - está público no docker hub)
$DOCKER_USER = Read-Host "Enter your Docker Hub username"

Write-Host "Tagging images for Docker Hub..." -ForegroundColor Green
docker tag prj1-database:latest ${DOCKER_USER}/prj1-database:latest
docker tag prj1-backend:latest ${DOCKER_USER}/prj1-backend:latest

Write-Host "Pushing images to Docker Hub..." -ForegroundColor Green
docker push ${DOCKER_USER}/prj1-database:latest
docker push ${DOCKER_USER}/prj1-backend:latest

Write-Host "Loading images into Minikube..." -ForegroundColor Green
minikube image load prj1-database:latest
minikube image load prj1-backend:latest

Write-Host "Creating hostPath directory in Minikube..." -ForegroundColor Green
minikube ssh "sudo mkdir -p /meubanco && sudo chmod 777 /meubanco"

Write-Host "Applying MySQL service and deployment..." -ForegroundColor Green
kubectl apply -f database/db-service.yml
kubectl apply -f database/db-deployment.yml

Write-Host "Waiting for MySQL pod to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=mysql-db --timeout=120s

Write-Host "Applying PHP service and deployment..." -ForegroundColor Green
kubectl apply -f backend/php-service.yml
kubectl apply -f backend/php-deployment.yml

Write-Host "Waiting for PHP pod to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=php-backend --timeout=120s

Write-Host "`nDeployment complete!" -ForegroundColor Green
Write-Host "`nChecking pod status:" -ForegroundColor Cyan
kubectl get pods

Write-Host "`nChecking services:" -ForegroundColor Cyan
kubectl get services

Write-Host "`nTo access the PHP backend, use:" -ForegroundColor Yellow
Write-Host "minikube service php-service --url" -ForegroundColor White
