# Build Docker images for the project

Write-Host "Building MySQL database image..." -ForegroundColor Green
docker build -t prj1-database:latest ./database

Write-Host "Building PHP backend image..." -ForegroundColor Green
docker build -t prj1-backend:latest ./backend

Write-Host "Images built successfully!" -ForegroundColor Green
docker images | Select-String "prj1-"
