# Kittygram 🐱

**Kittygram** is a production-ready social network application for cat lovers - an Instagram-style platform where users can share photos of their cats, showcase their achievements, and connect with other cat enthusiasts.

## 📋 Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Development Setup](#development-setup)
- [Production Deployment](#production-deployment)
- [Environment Variables](#environment-variables)
- [CI/CD Pipeline](#cicd-pipeline)
- [API Documentation](#api-documentation)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [License](#license)

## ✨ Features

- 🔐 **User Authentication**: Secure registration and login system using Djoser
- 🐈 **Cat Profiles**: Create and manage profiles for your cats with photos
- 🏆 **Achievements**: Track and showcase your cat's achievements
- 🎨 **Color Customization**: Specify your cat's fur color
- 📸 **Image Upload**: Upload and display cat photos
- 📱 **Responsive Design**: Beautiful UI that works on all devices
- 🔄 **RESTful API**: Well-structured API for frontend-backend communication
- 🚀 **Pagination**: Efficient browsing of cat profiles
- 🔍 **Search & Filter**: Find cats based on various criteria

## 🛠 Tech Stack

### Backend
- **Python 3.10+**
- **Django** - Web framework
- **Django REST Framework** - API development
- **Djoser** - Authentication
- **PostgreSQL 14** - Database
- **Pillow** - Image processing
- **Gunicorn** - WSGI HTTP Server

### Frontend
- **React 18** - UI library
- **React Router** - Navigation
- **CSS Modules** - Styling

### DevOps
- **Docker & Docker Compose** - Containerization
- **Nginx** - Reverse proxy and static file serving
- **GitHub Actions** - CI/CD pipeline
- **Docker Hub** - Container registry

### Testing
- **Pytest** - Backend testing
- **Flake8** - Code linting
- **Jest** - Frontend testing

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Docker** (20.10+)
- **Docker Compose** (2.0+)
- **Git**

For development without Docker:
- **Python** (3.10+)
- **Node.js** (18+)
- **PostgreSQL** (14+)

## 🚀 Quick Start

### Development Environment

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/kittygram-docker.git
   cd kittygram-docker
   ```

2. **Create environment file**
   ```bash
   cp .env.example .env
   ```
   Edit `.env` with your configuration

3. **Start the application**
   ```bash
   docker compose up -d
   ```

4. **Run migrations**
   ```bash
   docker exec backend python manage.py migrate
   ```

5. **Create superuser** (optional)
   ```bash
   docker exec backend python manage.py createsuperuser
   ```

6. **Access the application**
   - Frontend: http://localhost:9000
   - Admin panel: http://localhost:9000/admin/

## 💻 Development Setup

### Backend Development

```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

### Frontend Development

```bash
cd frontend
npm install
npm start
```

## 🌐 Production Deployment

### 1. Prepare Your Server

Ensure your server has:
- Docker and Docker Compose installed
- Domain name configured
- SSL certificate (recommended: Let's Encrypt)

### 2. Configure Environment

Create `.env` file on your server with production values:

```env
POSTGRES_DB=kittygram_db
POSTGRES_USER=kittygram_user
POSTGRES_PASSWORD=your_secure_password
DB_HOST=db
DB_PORT=5432
SECRET_KEY=your_django_secret_key
DEBUG=False
ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com
```

### 3. Deploy with Docker Compose

```bash
# Pull latest images
docker compose -f docker-compose.production.yml pull

# Start services
docker compose -f docker-compose.production.yml up -d

# Run migrations and collect static files
docker compose -f docker-compose.production.yml exec backend python manage.py migrate
docker compose -f docker-compose.production.yml exec backend python manage.py collectstatic --noinput
docker compose -f docker-compose.production.yml exec backend cp -r /app/collected_static/. /static/static/
```

## 🔐 Environment Variables

Create a `.env` file in the root directory:

```env
# Database Configuration
POSTGRES_DB=kittygram
POSTGRES_USER=kittygram_user
POSTGRES_PASSWORD=kittygram_password
DB_HOST=db
DB_PORT=5432

# Django Configuration
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1

# Docker Hub (for CI/CD)
DOCKER_USERNAME=your_dockerhub_username
DOCKER_PASSWORD=your_dockerhub_password

# Server Configuration (for deployment)
HOST=your.server.ip.address
USER=your_server_user
SSH_KEY=your_ssh_private_key

# Telegram Notifications (optional)
TELEGRAM_TO=your_telegram_chat_id
TELEGRAM_TOKEN=your_telegram_bot_token
```

## 🔄 CI/CD Pipeline

The project includes a comprehensive GitHub Actions workflow that automatically:

1. **Tests Backend**: Runs flake8 linting and Django tests
2. **Tests Frontend**: Runs npm tests
3. **Builds Images**: Creates Docker images for backend, frontend, and nginx
4. **Pushes to Docker Hub**: Uploads images to Docker Hub registry
5. **Deploys to Server**: Automatically deploys to your production server
6. **Sends Notification**: Sends Telegram message on successful deployment

### Setting Up GitHub Actions

1. Go to your repository Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `DOCKER_USERNAME` - Your Docker Hub username
   - `DOCKER_PASSWORD` - Your Docker Hub password
   - `HOST` - Your server IP address
   - `USER` - Your server username
   - `SSH_KEY` - Your server SSH private key
   - `TELEGRAM_TO` - Your Telegram chat ID
   - `TELEGRAM_TOKEN` - Your Telegram bot token

3. Push to `main` branch to trigger the workflow

## 📚 API Documentation

### Authentication Endpoints

- `POST /api/auth/users/` - Register new user
- `POST /api/auth/token/login/` - Login
- `POST /api/auth/token/logout/` - Logout

### Cat Endpoints

- `GET /api/cats/` - List all cats (paginated)
- `POST /api/cats/` - Create new cat profile
- `GET /api/cats/{id}/` - Get cat details
- `PUT /api/cats/{id}/` - Update cat profile
- `PATCH /api/cats/{id}/` - Partial update
- `DELETE /api/cats/{id}/` - Delete cat profile

### Achievement Endpoints

- `GET /api/achievements/` - List all achievements
- `POST /api/achievements/` - Create achievement

### Example Request

```bash
# Create a cat profile
curl -X POST http://localhost:9000/api/cats/ \
  -H "Authorization: Token your_auth_token" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Fluffy",
    "color": "orange",
    "birth_year": 2020,
    "achievements": [1, 2]
  }'
```

## 📁 Project Structure

```
kittygram-docker/
├── backend/                  # Django backend application
│   ├── cats/                # Cats app
│   │   ├── models.py       # Cat and Achievement models
│   │   ├── serializers.py  # DRF serializers
│   │   ├── views.py        # API views
│   │   └── admin.py        # Django admin configuration
│   ├── kittygram_backend/  # Project settings
│   │   ├── settings.py     # Django settings
│   │   └── urls.py         # URL configuration
│   ├── Dockerfile          # Backend container configuration
│   └── requirements.txt    # Python dependencies
├── frontend/               # React frontend application
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── utils/         # API utilities
│   │   └── images/        # Static images
│   ├── Dockerfile         # Frontend container configuration
│   └── package.json       # Node.js dependencies
├── nginx/                 # Nginx reverse proxy
│   ├── Dockerfile
│   └── nginx.conf         # Nginx configuration
├── .github/
│   └── workflows/
│       └── main.yml       # CI/CD workflow
├── docker-compose.yml     # Development configuration
├── docker-compose.production.yml  # Production configuration
└── README.md
```

## 🧪 Testing

### Run Backend Tests

```bash
# With Docker
docker exec backend python manage.py test

# Without Docker
cd backend
pytest
```

### Run Frontend Tests

```bash
# With Docker
docker compose exec frontend npm test

# Without Docker
cd frontend
npm test
```

### Run Linting

```bash
# Backend
docker compose exec backend flake8

# Check from host
cd backend
flake8
```

### Run Full Test Suite

```bash
# From project root
pytest
```

## 🐛 Troubleshooting

### Port Already in Use

If port 9000 is already in use, modify the port mapping in `docker-compose.yml`:

```yaml
ports:
  - "8080:80"  # Use 8080 instead of 9000
```

### Database Connection Issues

Ensure PostgreSQL container is running:

```bash
docker compose ps
docker compose logs db
```

### Static Files Not Loading

Collect static files again:

```bash
docker compose exec backend python manage.py collectstatic --noinput
```

### Permission Issues

If you encounter permission issues with volumes:

```bash
sudo chown -R $USER:$USER ./
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Dmitriy Zverev** - [GitHub Profile](https://github.com/dmitriy-zverev)

---

Made with ❤️ for cats and their humans
