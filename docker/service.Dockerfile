###############################################################################
#
# Service image for Harmony SMAP L2 gridding service
#  ghcr.io/nasa/harmony-smap-l2-gridder
#
# Transforms L2G (gridded trajectory) data into actual gridded data.
#
# This image:
# Installs dependencies via pip.
# Copies the service code into the Docker image.
#
###############################################################################
FROM python:3.12-slim-bookworm

WORKDIR "/home"

RUN apt-get update

# Install Pip dependencies
COPY pip_requirements.txt /home/

RUN pip install --no-input --no-cache-dir \
    -r pip_requirements.txt

# Copy service code.
COPY ./harmony_service harmony_service
COPY ./smap_l2_gridder smap_l2_gridder

# Configure a container to be executable via the `docker run` command.
ENTRYPOINT ["python", "-m", "harmony_service"]
