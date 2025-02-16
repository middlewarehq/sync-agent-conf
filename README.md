# Self-hosted Agent Setup Checklist

This guide will help you set up a self-hosted agent for MiddlewareHQ that supports either GitLab (self-hosted) or Bitbucket (cloud).

## Prerequisites

Before proceeding, ensure you have the following:

- Docker installed on your system and Docker daemon is running.
- Middleware Credentials: Contact your Middleware Systems administrator to obtain the `MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET` credentials required for authentication. Instructions for how to use them are below.

## For GitLab Integration

### Prerequisites

- **Personal Access Token (PAT)**: Generate a PAT with the `read_api` and `read_user` scopes to authenticate with the GitLab API.

### Setup Instructions

1. **Clone Configurations**:

   - Clone this repository: [Sync Agent Configurations](https://github.com/middlewarehq/sync-agent-conf)

2. **Middleware Credentials**:

   - Obtain the Middleware Credentials (`MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET`) from your Middleware Systems administrator.
   - Add these to `.env`.

3. **Generate Personal Access Token (PAT)**:

   - Obtain the domain URL (`GITLAB_DOMAIN_URL`) of your self-hosted GitLab instance in the format:
     - `https://gitlab.com/-/user_settings/personal_access_tokens` OR
     - `https://yourgitlabinstance.com/-/user_settings/personal_access_tokens`.
   - Generate a PAT with the `read_api` and `read_user` scopes to authenticate with the GitLab API.
   - Use this token (`GITLAB_ACCESS_TOKEN`) for authentication and update it when necessary for security reasons.
   - Add both `GITLAB_DOMAIN_URL` and `GITLAB_ACCESS_TOKEN` to `.env`.

4. **Define Repository URLs**:

   - Save the repository URLs in `config.json` under `integrations->gitlab->repositories`.

5. **Deploy the Agent**:

   - Run the following command to create and run the Docker container for the MHQ GitLab Agent in the project root:

   ```
   docker compose up -d
   ```

   This command deploys the agent in detached mode, allowing it to run independently in the background.
   (If you’re running this later, run `docker compose pull`)

## For Bitbucket Integration

### Prerequisites

- **Access Token**: Generate a Bitbucket Access Token with the following scopes:
  - `repository` (read access to repositories)
  - `pullrequest` (read access to pull requests)
  - `account` (read access to workspace users)

### Setup Instructions

1. **Clone Configurations**:

   - Clone this repository: [Sync Agent Configurations](https://github.com/middlewarehq/sync-agent-conf)

2. **Middleware Credentials**:

   - Obtain the Middleware Credentials (`MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET`) from your Middleware Systems administrator.
   - Add these to `.env`.

3. **Add Bitbucket Workspace Details**:

   - Add the following to `.env`:
     - `BITBUCKET_ACCESS_TOKEN`: The access token for your Bitbucket workspace.
     - `BITBUCKET_WORKSPACE_NAME`: The name or slug of your Bitbucket workspace.

4. **Define Repository URLs**:

   - Save the repository URLs in `config.json` under `integrations->bitbucket->repositories`.

5. **Deploy the Agent**:

   - Run the following command to create and run the Docker container for the MHQ Bitbucket Agent in the project root:

   ```
   docker compose up -d
   ```

   This command deploys the agent in detached mode, allowing it to run independently in the background.
   (If you’re running this later, run `docker compose pull`)

### Important Note

- **Single Integration Support**:
  - The agent currently supports only one integration at a time (either GitLab or Bitbucket).
  - Ensure that the JSON object for GitLab under `integrations` in `config.json` is removed if you are switching to Bitbucket.

## Additional Checks

### Docker Logs

- **Check Docker Logs**:
  - Check if the docker container is running properly:
    - Use the below command to get the list of all the Docker containers. Copy the ID of the Docker container with the name `mhq-sync-agent-scripts`.
      ```
      docker ps -a   
      ```
    - Use the below command with the ID of the container you copied from the previous step. This command will give the logs of the container.
      ```
      docker logs [id_of_container]
      ```
    - Check the logs to match the following. The order of the logs may differ. Finally, the exit status of `data-extraction-and-transfer` should be 0. It may take some time to get this last log as it depends on the amount of data it is trying to sync.

### Middleware App Integration

- **Verify Integration**:
  - Visit your Middleware App ([app.middlewarehq.com](https://app.middlewarehq.com)) to check if your app has integrated with the agent successfully.
    - Go to [Integrations](https://app.middlewarehq.com/integrations).
    - The integration should appear linked. The “Link” button as shown below would turn into *“Unlink”*.

### Database Management

- **Inspect Database**:
  - Use a database management tool like TablePlus to connect to the Docker PostgreSQL database and inspect logs for further analysis.
    - Ensure to configure with the following parameters:
      - Host: localhost or server IP address
      - Port: 5435
      - User: postgres
      - Password: postgres
      - Database: mhqagent

**NOTES:**

- Password change instructions coming soon.
- We recommend not exposing port 5435 on the machine that this is running on to any external network.

Follow the above steps to successfully set up and configure the self-hosted agent for MiddlewareHQ synchronization with GitLab or Bitbucket.

e



Follow above steps to successfully set up and configure the GitLab self-hosted agent for MiddlewareHQ synchronization.
