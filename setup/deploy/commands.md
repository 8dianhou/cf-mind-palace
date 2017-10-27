# CMDs:

### 1. **start**:
  - client: `npm run pub-prod`
  - server(incase service dies):
    ```
    cd deploy/run/$APP
    ./scripts/run/start_service.sh
    ```

### 2. **restart** (only in server):
  ```
  cd deploy/run/$APP
  ./scripts/run/update_service.sh
  ```

### 3. **rollback** (only in server):
- common(like history.back()):
  ```
  cd deploy/run/$APP
  ./scripts/run/rollback.sh
  ```

- rollback to a specific version:
  1. `cd deploy/run/$APP`
  2. edit file `.env`, change `IMAGE` value: <br>

    ```
    ...IMAGE=registry...cf-docker/$APP:$VERSION

    example:
    ...IMAGE=registry...cf-docker/cf-admin:v2.0.0
    ```

  3. update service:
    ```
      ./scripts/run/update_service.sh
    ```
