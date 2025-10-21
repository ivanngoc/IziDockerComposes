# Setup
docker network create gitlab-network

# ENV variables
GITLAB_HOME = "C:\Users\ivan\Documents\gitlab"
GITLAB_RUNNER_HOME
GITLAB_EXTERNAL_URL
# CLI
docker compose -f docker-compose.gitlab.yml up -d
docker compose -f docker-compose.gitlab-runners.yml up -d

docker exec -it gitlab gitlab-ctl reconfigure
or from inside container
docker restart gitlab

# Setup Runner
gitlab-runner register

Enter the GitLab instance URL (for example, https://gitlab.com/):
http://gitlab:4080
Enter the registration token:
B96gSDZJUzDha6FJUW2J
Enter a description for the runner:
[8bd7113508f0]: gitlab-runner-1
Enter tags for the runner (comma-separated):
build, test, publish, deploy
Enter optional maintenance note for the runner:
docker compose                  
WARNING: Support for registration tokens and runner parameters in the 'register' command has been deprecated in GitLab Runner 15.6 and will be replaced with support for authentication tokens. For more information, see https://docs.gitlab.com/ci/runners/new_creation_workflow/ 
Registering runner... succeeded                     correlation_id=01K27695126KNT8HK3E785T2Q9 runner=B96gSDZJU
Enter an executor: custom, shell, parallels, virtualbox, instance, ssh, docker, docker-windows, docker+machine, kubernetes, docker-autoscaler:
docker
Enter the default Docker image (for example, ruby:3.3):
alpine:latest
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

# Docker compose
http://gitlab:4080
Registration token:
http://localhost:4080/admin/runners
example:
B96gSDZJUzDha6FJUW2J