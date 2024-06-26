# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:3.10.11-slim-buster

# Récupération fichiers
COPY . /MERAH_Mohamed_1_dashboard_062024

# Répertoire de travail
WORKDIR /MERAH_Mohamed_1_dashboard_062024

# Dépendance pour LightGBM
RUN apt-get update
RUN apt-get install -y libgomp1


# Using pip:
RUN python -m pip install -r requirements.txt

# Déclaration du port d'entrée à l'app depuis l'extérieur du container
EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

# Déplacement des fichiers de configuration de streeamlit

RUN cp config.toml ~/config.toml
RUN cp credentials.toml ~/credentials.toml
WORKDIR /MERAH_Mohamed_1_dashboard_062024

# Lance streamlit
CMD ["streamlit", "run","MERAH_Mohamed_1_dashboard_062024.py"]