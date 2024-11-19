# Utiliser l'image officielle Jenkins LTS comme base
FROM jenkins/jenkins:lts

# Passer à l'utilisateur root pour pouvoir installer Docker CLI
USER root

# Ajouter le dépôt Docker et installer Docker CLI
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    && curl -fsSL https://get.docker.com | sh \
    && apt-get clean

# Revenir à l'utilisateur jenkins par défaut
USER jenkins

# Définir un volume pour les configurations de Jenkins et les builds
VOLUME /var/jenkins_home
#RUN chmod 777 /var/jenkins_home 
# Exposer les ports nécessaires pour Jenkins
EXPOSE 8080
EXPOSE 50000

# Commande pour démarrer Jenkins
ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
