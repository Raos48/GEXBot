Agendador de Mensagens WhatsApp
📖 Sobre o Projeto
O Agendador de Mensagens WhatsApp é uma aplicação backend robusta projetada para automatizar o envio de mensagens via WhatsApp. Construída com Django e Celery, e totalmente containerizada com Docker, a plataforma permite o gerenciamento de contatos, grupos e templates de mensagens, além do agendamento de envios com diversas frequências (execução única, diária, semanal, mensal).
A aplicação fornece uma API RESTful completa para ser consumida por um frontend, permitindo a criação de uma interface de usuário rica e interativa.
✨ Funcionalidades Principais
Gerenciamento Completo via API: Endpoints para criar, ler, atualizar e deletar (CRUD) contatos, grupos, templates e agendamentos.
Agendamento Flexível: Suporte para envios de execução única, diários, semanais e mensais.
Sistema de Tarefas Assíncronas: Utiliza Celery para processar o envio de mensagens em segundo plano, garantindo que a API permaneça rápida e responsiva.
Agendador Persistente: Usa django-celery-beat com um DatabaseScheduler para que os agendamentos sejam armazenados no banco de dados e sobrevivam a reinicializações do sistema.
Autenticação Segura: Proteção de todos os endpoints da API com autenticação baseada em token.
Ambiente Containerizado: Todos os serviços (Nginx, Django/Gunicorn, MySQL, Redis, Celery) são gerenciados pelo Docker Compose, garantindo um setup de desenvolvimento e produção simples e consistente.
Endpoints para Dashboard: Fornece rotas específicas para obter estatísticas agregadas, facilitando a criação de painéis de monitoramento.
🚀 Como Executar o Projeto
Siga os passos abaixo para configurar e executar o ambiente de desenvolvimento local.
Pré-requisitos
Docker
Docker Compose
1. Clonar o Repositório
git clone <url_do_seu_repositorio>
cd nome-do-projeto


2. Configurar Variáveis de Ambiente
Crie uma cópia do arquivo .env.example (se existir) ou crie um novo arquivo chamado .env na raiz do projeto.
Preencha as seguintes variáveis:
# .env
SECRET_KEY=sua-chave-secreta-aqui
DEBUG=True

# Configuração do Banco de Dados
DB_NAME=whatsapp_scheduler
DB_USER=gexbot_user
DB_PASSWORD=sua_senha_segura
MYSQL_ROOT_PASSWORD=sua_senha_segura # Deve ser igual à DB_PASSWORD
DB_HOST=db
DB_PORT=3306

# Configuração da Evolution API
EVOLUTION_API_BASE_URL=http://sua-evolution-api:8080
EVOLUTION_API_KEY=sua-api-key
EVOLUTION_INSTANCE_NAME=sua-instancia

# Configuração do Celery
CELERY_BROKER_URL=redis://redis:6379/0
CELERY_RESULT_BACKEND=redis://redis:6379/0


3. Iniciar a Aplicação
Use o Docker Compose para construir as imagens e iniciar todos os serviços.
docker-compose up --build -d


O -d executa os contêineres em modo "detached" (em segundo plano).
4. Configurar o Banco de Dados
Com os contêineres em execução, abra um novo terminal e execute os seguintes comandos para preparar o banco de dados:
Aplicar as migrações:
docker-compose exec web python manage.py migrate


Criar um superusuário:
docker-compose exec web python manage.py createsuperuser

Siga as instruções para criar seu usuário administrador.
5. Acessar a Aplicação
API: A API estará disponível em http://localhost:8000/api/
Django Admin: O painel administrativo estará acessível em http://localhost:8000/admin/
🛠️ Visão Geral da API
A API é o coração da aplicação. Todos os endpoints requerem um token de autenticação.
Obter Token: Faça um POST para /api-token-auth/ com seu username e password.
Autenticar Requisições: Adicione o cabeçalho Authorization: Token <seu_token> a todas as chamadas subsequentes.
Recurso
Endpoint
Contatos
/api/contacts/
Grupos
/api/groups/
Templates
/api/templates/
Agendamentos
/api/schedules/
Logs de Envio
/api/logs/
Configs. Evolution
/api/evolution-configs/
Estatísticas
/api/dashboard/stats/

⚙️ Tecnologias Utilizadas
Backend: Django, Django REST Framework
Servidor de Aplicação: Gunicorn
Proxy Reverso: Nginx
Banco de Dados: MySQL
Tarefas Assíncronas: Celery, Redis
Agendamento: Django Celery Beat
Containerização: Docker, Docker Compose
