## Create folder {project} change directory to it.
### Clone the repo
```
git clone git@github.com:techbizz-nepal/deployment.git 
```
### Create Makefile from this gists
```
https://gist.github.com/susantp/cc3933204be17cf07f06a80b6d468ad9
```
## Inside Project root run these steps to start the project

### give permission to run the script

```
chmod +x ./deployment/prepare_context.sh
```

### build enviroment

```
./deployment/prepare_context.sh build
```

# After setting up environment you can start your project in src folder 
