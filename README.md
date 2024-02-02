# GitLab Self-hosted Agent Setup Checklist

This guide will help you set up a GitLab self-hosted agent for MiddlewareHQ.

## Prerequisites

Before proceeding, ensure you have the following:

- Docker installed on your system.
- Middleware Credentials: Contact your Middleware Systems administrator to obtain the `MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET` credentials required for authentication. Instructions for how to use them are below.
- Personal Access Token (PAT): Generate a PAT with the `read_api` and `read_user` scopes to authenticate with the GitLab API.

## Setup Instructions

1. **Clone Configurations**:
   - Clone this repository: [Sync Agent Configurations](https://github.com/middlewarehq/sync-agent-conf)

2. **Middleware Credentials**:
   - Obtain the Middleware Credentials (`MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET`) from your Middleware Systems administrator.

3. **Generate Personal Access Token (PAT)**:
   - Obtain the domain URL of your self-hosted GitLab instance in the format `https://gitlab.example.com` (`GITLAB_DOMAIN_URL`).
   - Generate a PAT with the `read-api` and `read-user` scopes to authenticate with the GitLab API.
   - Use this token (`GITLAB_ACCESS_TOKEN`) for authentication and update it when necessary for security reasons.

4. **Define Repository URLs**:
   - Create a `config.json` file in the same directory as the `docker-compose.yml` file to store repository URLs for synchronization with Middleware Systems.
   - Save the repository URLs in `config.json` for reference during synchronization.

5. **Deploy the Agent**:
   - Run the following command to create and run the Docker container for the MHQ GitLab Agent:
     ```
     docker-compose up -d
     ```
     This command deploys the agent in detached mode, allowing it to run independently in the background.

## Additional Checks

- **Check Middleware App Integration**:
  - Visit your Middleware App to check if your app has integrated with the GitLab self-hosted agent successfully.
    

- **Database Management**:
  - Use a database management tool like TablePlus to connect to the Docker PostgreSQL database and inspect logs for further analysis.
  - Use the following credentials to connect to the database:
    - Host: `localhost or server IP address`
    - Port: `5435`
    - User: `postgres`
    - Password: `postgres`
    - Database: `mhqagent`

Follow above steps to successfully set up and configure the GitLab self-hosted agent for MiddlewareHQ synchronization.
