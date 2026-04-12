[![Build nginx and push Docker image to dockerhub](https://github.com/techbizz-nepal/deployment/actions/workflows/docker_image.yml/badge.svg?branch=bazzarify-config&event=push)](https://github.com/techbizz-nepal/deployment/actions/workflows/docker_image.yml)

## Project Overview

This project is designed to assist with deploying a stack consisting of Laravel, MySQL, and Redis. It simplifies the process of setting up your application in a Docker environment with just a few commands. Follow the steps below to get started and enjoy a seamless deployment experience.

Happy building! 🚀

## Setting Up Your Project

1. **Create and Navigate to Project Directory**
   ```
   mkdir {project} && cd {project}
   ````
2. **Clone the repo**
    ```
    git clone git@github.com:techbizz-nepal/deployment.git 
    ```
3. **Create Makefile in the Root Directory.**
    ```
    curl https://gist.githubusercontent.com/susantp/cc3933204be17cf07f06a80b6d468ad9/raw/8c3a7a5788c48c165f8f25738bd06823e3a77864/Makefile | >> Makefile
    ```
### Starting the Project
1. **Clone the laravel project as the `src` folder.**
    ```
    git clone git@github.com:{username}/{repo_name}.git src
    ```
2. Give Permission to Run the Script
    ```
    chmod +x ./deployment/prepare_context.sh
    ```
3. Build the project
    ```
    ./deployment/prepare_context.sh build
    ```
---

By following these steps, you should have a fully functional Laravel, MySQL, and Redis stack running in Docker. If you encounter any issues or have questions, feel free to open an issue on the repository or consult the documentation.

Happy coding, and enjoy your streamlined development and deployment process! 😊

## Queue Runtime Notes

- production async workloads such as product CSV import now expect:
  - `QUEUE_CONNECTION=redis`
  - a dedicated `queue-worker` service running `php artisan queue:work redis ...`
- the application container and worker both read the same queue connection so import processing can dispatch from web requests and complete in the background
- if you intentionally force `QUEUE_CONNECTION=sync`, imports still work, but they run inline and you lose the intended background progress behavior

## Small Instance Notes

- the committed production compose file is tuned for a low-cost single-node EC2 host such as `t2.small`, prioritizing memory breathing room while staying inside a `1 vCPU` budget
- this profile assumes:
  - low traffic
  - Redis-backed queues remain enabled
  - a dedicated `queue-worker` still runs
  - Postgres remains on the same box
  - host swap is still configured (`1-2 GB` recommended)
- expected tradeoffs:
  - workable day-to-day responsiveness for a development-stage environment
  - queue/import jobs still remain capacity-sensitive
  - safe concurrency is still low
  - large imports or bursty admin operations can still create pressure
- if the stack still feels CPU-tight or background jobs become routine, move to `t3.small` or `t3.medium` instead of continuing to raise caps on this profile
