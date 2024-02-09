# GitLab Self-hosted Agent Setup Checklist

This guide will help you set up a GitLab self-hosted agent for MiddlewareHQ.

## Prerequisites

Before proceeding, ensure you have the following:

- Docker installed on your system and docker daemon is running.
- Middleware Credentials: Contact your Middleware Systems administrator to obtain the `MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET` credentials required for authentication. Instructions for how to use them are below.
- Personal Access Token (PAT): Generate a PAT with the `read_api` and `read_user` scopes to authenticate with the GitLab API.

## Setup Instructions

1. **Clone Configurations**:
   - Clone this repository: [Sync Agent Configurations](https://github.com/middlewarehq/sync-agent-conf)

2. **Middleware Credentials**:
   - Obtain the Middleware Credentials (`MHQ_CLIENT_ID` and `MHQ_CLIENT_SECRET`) from your Middleware Systems administrator.
   - Add these to `client.txt`.

3. **Generate Personal Access Token (PAT)**:
   - Obtain the domain URL (`GITLAB_DOMAIN_URL`) of your self-hosted GitLab instance in the format:
     - `https://gitlab.com/-/user_settings/personal_access_tokens` OR
     - `https://yourgitlabinstance.com/-/user_settings/personal_access_tokens`.
   - Generate a PAT with the `read_api` and `read_user` scopes to authenticate with the GitLab API. 
   - Use this token (`GITLAB_ACCESS_TOKEN`) for authentication and update it when necessary for security reasons.
   - Add both to `client.txt`.


4. **Define Repository URLs**:
   - Save the repository URLs in `config.json` for reference during synchronization in `integrations->gitlab->repositories`.

5. **Deploy the Agent**:
   - Run the following command to create and run the Docker container for the MHQ GitLab Agent in the project root:
    ```
    docker compose up -d
    ```
    This command deploys the agent in detached mode, allowing it to run independently in the background.
    (If you’re running this later, run `docker compose pull`)

## Additional Checks

- **Check Docker Logs**:
  - Check if the docker container is running properly:
    - Use the below command to get the list of all the docker containers. Copy the id of the docker-container with the name `mhq-sync-agent-scripts`.
       ```
       docker ps -a   
       ```
    - Use the below command with the id of the container you copied from the previous step. This command will give the logs of the container.
       ```
       docker logs [id_of_container]
       ```
    - Check the logs to match the following. The order of the logs may differ. Finally, The exit status of data-extraction-and-transfer shall be 0. It may take some time to get this last log as it depends on the amount of data it is trying to sync.
      <img width="749" alt="image" src="https://github.com/middlewarehq/sync-agent-conf/assets/34140672/e68dcad6-e46a-4e16-a681-b3d8832b71f7">


- **Check Middleware App Integration**:
  - Visit your Middleware App ([app.middlewarehq.com](https://app.middlewarehq.com)) to check if your app has integrated with the GitLab self-hosted agent successfully.
    - Go to [Integrations](https://app.middlewarehq.com/integrations).
    - Gitlab’s integration should appear linked. The “Link” button as shown below would turn into *“Unlink”*.
      <img width="267" alt="image" src="https://github.com/middlewarehq/sync-agent-conf/assets/34140672/273a5d9d-2eeb-4935-aa6a-af0e23ba5704">

    - Visit [Teams](https://app.middlewarehq.com/teams).
    - Select a team of your choice from the list.
    - Click on the “Repos” tab right under the page header.
      <img width="746" alt="image" src="https://github.com/middlewarehq/sync-agent-conf/assets/34140672/28cbee28-1353-46d1-a1dc-39e992320c6a">

    - Your repos will show up under “Repos linked to your org”.
    - Click on the << icon on each repo you want to add to the team.
      <img width="126" alt="image" src="https://github.com/middlewarehq/sync-agent-conf/assets/34140672/2f7101d5-9a0f-4a2b-9d16-91eca763386a">

    - A “notification” will indicate that your settings have been saved.
    - Voila! You are good to start using middleware app.
      * Process Overview (https://app.middlewarehq.com/collaborate/process) is a great place to start viewing your first insights.
      * If you don’t see anything even after 5 minutes or so, let us know on jayant@middlewarehq.com or dhruv@middlewarehq.com.
    

- **Database Management**:
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


Follow above steps to successfully set up and configure the GitLab self-hosted agent for MiddlewareHQ synchronization.
