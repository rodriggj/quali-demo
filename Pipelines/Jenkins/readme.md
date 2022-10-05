# Jenkins Pipeline

## Purpose
> Purpose of this page is to provide an example of Jenkins integration to Quali - Torque. This will provide a step by step procedure as well as some additional setup dialog and Frequently Asked Questions (FAQs). Intention is that this document will be a updated as Jenkins or Quali is versioned and modified over time. The intended audience will be any internal or external stakeholders looking for guidance or an example of Jenkins integration procedure to Torque. 

## Environment Setup 
> Before integrating Jenkins to Quali - Torque you will need an instance of Jenkins running. Jenkins as a tool can be hosted in several environments on several platforms. If you would like to review Jenkins documentation do so [here](https://www.jenkins.io/). For our purposes this demo assumes that we will be installing a containerized, Docker image, with Jenkins installed locally on a macOs. 

- [ ] Download and install `homebrew` on macOS. `homebrew` is a package manager used for macOS operating system.
- [ ] Download and install `DockerDesktop` for macOS. `DockerDesktop` is a virtualization layer that will allow a Docker image to run locally. 
- [ ] Download and Install Jenkins container image. 
- [ ] 

### Jenkins Download

Steps: 
1. Jenkins is a containerized image if run locally on a macOS. To interact with the container you will need some tooling that can be installed via `Docker Desktop` for macOS. If you do not have `Docker Desktop` installed. See download and installation instructions [here](https://www.docker.com/products/docker-desktop/). 

2. After verifying `Docker Desktop` installation, ensure that you have `Docker` daemon server running.

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194106381-160e189d-c9be-482c-a05c-02e0109d4edc.png">
</p>

3. Jenkins documentation will direct you to a process of using `homebrew` for Jenkins installation. The `installer` functionality has been deprecated. If you do not have `homebrew` installed you can find and download the necessary files [here](https://brew.sh/).  

4. Go [here](https://www.jenkins.io/download/) to download the Jenkins image for [macOS](https://www.jenkins.io/download/weekly/macos/).

5. Open a terminal session. There is no need to worry about the local working directory, but it may be wise to navigate to the `Desktop` to ensure a consistent starting location should file location matter elsewhere in this instruction set. Enter the following commands. 

```s
cd ~/Desktop
brew install jenkins
```

Your terminal screen should look like this ... 
<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194107323-54ff3aca-eee4-499a-a89e-a2486f081aeb.png">
</p>

6. When the terminal screen completes, check to see if there were any installation errors. These will be displayed with some messaging on the terminal console. You can also validate that the install was successfully by running the following command. 

```s
jenkins --version
``` 

Which should reveal a console output that validates the version of the installation. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194108330-8b288e08-3d98-43a6-baa6-cc66aa5aa5ae.png">
</p>

7. Now that the image has been installed, you should be able to `start` the Jenkins service. To do so you can execute the following command. 

```s
brew services start jenkins
```

You should see terminal output similar to the following: 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194108715-a9526f64-2d01-4e11-b18a-c26abb89c8c9.png">
</p>

8. With the service started you now have to simply go to a browser session (open Google Chrome or other Browser) and input the following URL: 

```s
http://localhost:8080
```

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194109536-6ee5a410-4b59-4069-81ec-5ba4a68aa7f3.png">
</p>

> NOTE: The first time you navigate to a browser session you will have additional configuration that the UI will guide you through. This will not be the case after initial session, you will simply be presented with a login screen. 

> ADDITIONAL NOTE: This is a demo. You would not instantiate a production grade Jenkins pipeline without additional configuration. For example note that you are communicating on an unsecure `http` protocol. You can configure TLS certificates on an `https` protocol. Additionally you are identifying the URL by the public IP and port, this can be configured via a DNS service for production instances. 

9. Complete the configuration wizard. The first step will be to enter the `Admin Password` that Jenkins assigned. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194110469-f04ab1b3-8846-4cee-b277-64739ee6ce90.png">
</p>

Copy the file path in red letters on the screen, and enter the following command: 

```s
cat /Users/gabrielrodriguez/.jenkins/secrets/initialAdminPassword
```

The terminal will display a long string of characters. Copy/paste this string back into the UI and press "Continue" which should advance you to the Plugins configuration.

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194111131-b7055b93-7125-404a-ab80-a3ec737cdcc2.png">
</p>

10. Configure the plugins. Simply click the `Install Suggested Plugins`. You will be able to modify additional plugins as needed later in the configuration process. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194111461-a0afaa91-90ae-4a51-ab9f-e54a031f5fae.png">
</p>

This should result in a UI screen showing Plugin installation status. Once the installation completes the UI should advance you to a screen for Admin User registration. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194111866-a535c8ea-103b-44b7-8258-14b1b1cdab86.png">
</p>

11. Register an `Administrative User`. Populate the required fields and click "Save and Continue". 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194112602-d285e88d-5bf4-4e07-8add-f545161fe70f.png">
</p>

12. Finally, you can configure the URL for Jenkins instance. As this is for a local demo purpose, leaving the default as is fine. If you have a dedicated host or a proxy (e.g. `ngrok`) then you can modify here. Otherwise click "Save and Finish".

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194113139-16eb0b07-c722-4417-80fa-f8dbdda81513.png">
</p>

13. Now you have a configured Jenkins instance where you can proceed to additional steps of integration with Torque.

Click "Start Using Jenkins"

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194113446-82c9c594-f6a6-4ba8-a9ad-6de429ecdca1.png">
</p>

You should be presented with the Jenkins Dashboard.

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194113804-cac6a010-2661-4f63-b77e-34488f8deb2f.png">
</p>


## Integration to Quali

## FAQ

## References
