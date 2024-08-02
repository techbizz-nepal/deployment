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