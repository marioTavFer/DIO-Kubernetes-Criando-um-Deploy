# Load e deploy do projeto do Docker Hub

Write-Host "Pull de imagens do Docker Hub..." -ForegroundColor Green
docker pull marioltf/prj1-database:latest
docker pull marioltf/prj1-backend:latest

Write-Host "Tag das images como local..." -ForegroundColor Green
docker tag marioltf/prj1-database:latest prj1-database:latest
docker tag marioltf/prj1-backend:latest prj1-backend:latest

Write-Host "Load das imagens no Minikube..." -ForegroundColor Green
minikube image load prj1-database:latest
minikube image load prj1-backend:latest

Write-Host "Criando diretório hostPath no Minikube..." -ForegroundColor Green
minikube ssh "sudo mkdir -p /meubanco && sudo chmod 777 /meubanco"

Write-Host "Apply do serviço MySQL e seu deployment..." -ForegroundColor Green
kubectl apply -f database/db-service.yml
kubectl apply -f database/db-deployment.yml

Write-Host "Tempo de espera para MySQL pod ficar ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=mysql-db --timeout=120s

Write-Host "Apply do serviço PHP e seu deployment..." -ForegroundColor Green
kubectl apply -f backend/php-service.yml
kubectl apply -f backend/php-deployment.yml

Write-Host "Tempo de espera para PHP pod ficar ready..." -ForegroundColor Yellow
kubectl wait --for=condition=ready pod -l app=php-backend --timeout=120s

Write-Host "`nDeployment terminado!" -ForegroundColor Green
Write-Host "`nCheck do pod status:" -ForegroundColor Cyan
kubectl get pods

Write-Host "`nCheck dos serviços:" -ForegroundColor Cyan
kubectl get services

Write-Host "`nCheck dos serviços:" -ForegroundColor Cyan
minikube service list

Write-Host "`nPara acessar PHP backend, usar:" -ForegroundColor Yellow
Write-Host "minikube service php-service --url" -ForegroundColor White
