# traefik
My traefik repository

This traefik setup is configured for local development only!

Prequisites:
1. Docker Engine
2. DNS masq configured

Installation Steps:
1. Set the correct env variables and rename .env.sample to .env
2. Set the env variables
3. Run the certs.sh (this sh has been tested only on fedora OS)
4. run 
    ```
        docker compose up
    ```
5. Enjoy!

Tips:
1. Make sure the certificate authority is installed in your browser!
