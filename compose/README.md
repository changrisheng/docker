# Docker guideline
1. Install Docker Toolbox

    - Mac: https://docs.docker.com/mac/
    - Linux: https://docs.docker.com/linux/
    - Windows: https://docs.docker.com/windows/

2. Run default docker machine: `docker-machine start default`

    ```Bash
    docker-machine start default #maybe need to restart
    docker-machine env default
    eval "$(docker-machine env default)"
    ```

3. Build images && create containners:

    ```Bash
    docker-compose up
    ```
5. Start containners:

    ```Bash
    docker-compose start
    ```