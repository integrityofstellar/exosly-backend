# Exosky Backend
## Description

This API provides endpoints to fetch and manage data on exoplanets and stars. It allows querying exoplanets and nearby stars using the Gaia catalog, with responses including calculated 3D positions and intensities. The application uses FastAPI for creating RESTful endpoints and Redis for caching data.

## Technical Details

- **Backend Framework**: FastAPI
- **Data Source for Exoplanets**: IPAC Exoplanet Archive
- **Data Source for Stars**: Hipparcos
- **Caching**: Redis
- **Data Processing**: Numpy for mathematical computations
- **API Documentation**: (Swagger) Auto-generated by FastAPI

- **`app/api/`**: Contains endpoints for handling exoplanet and star data.
- **`app/schemas.py`**: Defines Pydantic models for request and response validation.
- **`.env`**: Environment variables for configuration.
- **`main.py`**: Entry point for running the FastAPI application.

## Prerequisites for Automatic Installation

## Automatic run
```bash
docker compose up -d
```
This will start the server at `http://127.0.0.1:8000`.



## Prerequisites for Manual Installation
The following prerequisites are required and must be installed manually:
- [Python 3.10 or higher](https://www.python.org/)
- [Poetry](https://python-poetry.org/)
- [Redis](https://redis.io/) Either locally or in the cloud 
- [Insomnia](https://insomnia.rest/) or [Postman](https://www.postman.com/) for API testing (optional)


## Setup and Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/integrityofstellar/exosky-backend.git
   cd exosky-backend-nasa-d
   ```

2. **Create and Activate a Virtual Environment using Poetry**

   ```bash
   poetry shell
   ```

3. **Install Dependencies**

   ```bash
   poetry install
   ```

4. **Set Up Environment Variables**

   Create a `.env` file in the root directory by copying the `example.env` file and replace content if needed:

   ```bash
   cp example.env .env
   ```

## Running the Application

To start the FastAPI application, run:

```bash
uvicorn main:app --reload
```

This will start the server at `http://127.0.0.1:8000`.

## API Endpoints
For more details follow the server at `http://127.0.0.1:8000/docs` (or your other server ip:port) to access `Swagger` documentation

### Fetch Exoplanets

- **URL**: `/api/exoplanets/`
- **Method**: `GET`
- **Query Parameters**:
  - `use_local_dataset` (optional, default: `True`): Use local file or fetch from the remote API.
  - `limit` (optional, default: `20`): Number of records to return.
  - `offset` (optional, default: `0`): Pagination offset.

- **Response**:
  - `data`: List of exoplanets.
  - `metadata`: Information about pagination.

### Fetch Stars

- **URL**: `/api/stars/`
- **Method**: `POST`
- **Request Body** (JSON):
  ```json
  {
    "ra": 123.456,
    "dec": 78.910
  }
  ```
- **Query Parameters**:
  - `radius` (optional, default: `5`): Radius for the search area around the coordinates.
  - `limit` (optional, default: `3000`): Number of records to return.
  - `force_skip_cache` (optional, default: `False`): Skip cache and fetch fresh data.

- **Response**:
  - `data`: List of stars with 3D positions and intensity.
  - `metadata`: Information about total amount of stars.

## Maintenance

1. **Updating Dependencies**

   To update project dependencies, modify `pyproject.toml` and run:

   ```bash
   poetry install
   ```

    OR

    ```bash
    poetry add PACKAGE
    ```

2. **Caching Configuration**

   Redis configuration can be updated in the `.env` file to match your Redis setup.

3. **Data Source Updates**

   The data sources for exoplanets and stars are queried from external APIs. Ensure that these sources are available and update the API endpoints if necessary.

4. **Logs and Monitoring**

- [ ] Implement logging and monitoring for production environments to track application performance and errors.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes. Ensure that your changes include tests and adhere to the project's coding standards.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

