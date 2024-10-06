# Use an official Python runtime as a parent image
FROM python:3.10-slim as python-base

# https://python-poetry.org/docs#ci-recommendations
ENV POETRY_VERSION=1.8.3
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VENV=/opt/poetry-venv

# Tell Poetry where to place its cache and virtual environment
ENV POETRY_CACHE_DIR=/opt/.cache

# Create stage for Poetry installation
FROM python-base as poetry-base

# Creating a virtual environment just for poetry and install it with pip
RUN python3 -m venv $POETRY_VENV \
    && $POETRY_VENV/bin/pip install -U pip setuptools \
    && $POETRY_VENV/bin/pip install poetry==${POETRY_VERSION}

# Create a new stage from the base python image
FROM python-base as fastapi_app

# Copy Poetry to app image
COPY --from=poetry-base ${POETRY_VENV} ${POETRY_VENV}

# Add Poetry to PATH
ENV PATH="${PATH}:${POETRY_VENV}/bin"

WORKDIR /app

# Copy Dependencies
COPY poetry.lock pyproject.toml ./

# Install Dependencies
RUN poetry install --no-interaction --no-cache --without dev,test

# Copy Application
COPY . .

# Run Application
CMD [ "poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8001"]