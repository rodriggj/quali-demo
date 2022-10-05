# Jenkins Pipeline

## Purpose
> Purpose of this page is to provide an example of Jenkins integration to Quali - Torque. This will provide a step by step procedure as well as some additional setup dialog and Frequently Asked Questions (FAQs). Intention is that this document will be a updated as Jenkins or Quali is versioned and modified over time. The intended audience will be any internal or external stakeholders looking for guidance or an example of Jenkins integration procedure to Torque. 

## Environment Setup 
> Before integrating Jenkins to Quali - Torque you will need an instance of Jenkins running. Jenkins as a tool can be hosted in several environments on several platforms. If you would like to review Jenkins documentation do so [here](https://www.jenkins.io/). For our purposes this demo assumes that we will be installing a containerized, Docker image, with Jenkins installed locally on a macOs. 

- [ ] Download and install `homebrew` on macOS. `homebrew` is a package manager used for macOS operating system.
- [ ] Download and install `DockerDesktop` for macOS. `DockerDesktop` is a virtualization layer that will allow a Docker image to run locally. 
- [ ] Download and Install Jenkins container image.

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

14. Since this is a demo environment you may want to stop Jenkins from running. If so, open your terminal and execute the following command. 

```s
brew services stop jenkins
```

Which should result in a terminal screen that looks like this

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194116924-b1491edb-c1a6-4634-a7c3-e129b4e7e5be.png">
</p>

There are times when the `stop` process will not work for various reasons. In those instances you may need to attempt other `quit` or `kill` processes. For any reason you need to stop or kill a process that may have bound to a port see reference instructions [here](https://damien.co/blog/2012-11-28-how-to-start-stop-restart-or-reload-jenkins-mac-osx/).


## Integration to Quali

Steps: 
1. Navigate to your `Torque` account and sign in. 
2. Along the left-nav pane, select `Integrations`. When the UI renders, you will see several tiles that indicate existing integrations. On the "Jenkins" tile select `Connect`. A right-tray will render with procedures to follow for the integration. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194123109-78b723fe-70c3-4765-929d-72cb4173d47e.png">
</p>

3. The first procedure drop-down is titled `General` and it provides a link to a github repository for a plugin download. This plugin will be required to configure with Jenkins Plugin Manager. Select the `Torque plugin` link and when redirected, download the the `jenkins-torque-plugin.hpi` file. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194127203-47496075-7fcb-4957-90ec-578e012e7f31.png">
</p>

4. Now that the file is downloaded, we can progress to the second drop-down which tells you to integrate the downloaded file with Jenkins Plugin Manager. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194124670-b2d9450c-1c89-4313-b4c6-95d71cadf3c9.png">
</p>

If you navigate over to the browser session to the Jenkins Dashboard you should see an option for `Manage Jenkins`. Select this option. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194125069-55b04d69-4029-4edd-b57a-bb8a8024b2b5.png">
</p>

When the UI redirects to the next page you will see an option to `Manage Plugins`

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194125354-87b93425-18ed-48f9-9fb4-3e98a1714f76.png">
</p>

When the UI redirects to the next page select the `Advanced Settings` option 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194125817-03441678-e576-40fe-905c-7046fe947aba.png">
</p>

When the UI redirects scroll down to the lower section of the page to `Deploy Plugin`

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194126493-abd8fd6b-92ca-4a61-b983-049f9bf513db.png">
</p>

Select the `Choose File` button and select the `jenkins-torque-plugin.hpi` file you downloaded. Click `Deploy`.

You should see `Success` on the `Download Progress`. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194128214-65b620ed-ae8e-4d4a-b99a-d7b035e7d2bd.png">
</p>

4. Now we can move on to `3. Configure` directions. Here they tell you to login as an `Administrator` if you haven't already. In my case I am the `Admin` so I can proceed to the additional configuration steps. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194128788-21b92791-7af9-4e65-a724-290b464f6579.png">
</p>

5. Navigate to the `Manage Jenkins` screen. You can use the breadcrumb if you are already logged in as an Admin. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194129245-55424b73-351d-4b9f-adf9-ecb8401bf164.png">
</p>

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194129614-e7d6aa09-5943-4c4a-af5a-dbe6ed215ec7.png">
</p>

6. Scroll down to the `Torque Configure` section. Here we will have 2 steps involving `a`. Jenkins and `b`. Torque. 

<img width="1285" alt="image" src="https://user-images.githubusercontent.com/8760590/194129929-73ab5421-1538-47b9-b92a-0c8cf389e844.png">

6a. On the Jenkins screen, on the field labeled `Domain name or IP` replace the placeholder text with `https://portal.qtorque.io`.

6b. On the same Jenkins screen, on the field labeled `Token` you need to input the token generated from Torque. Nav over to the Torque screen and click `Generate Token`

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194130701-303718d8-e452-41e6-ba48-a4f1c8bbca75.png">
</p>

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194130953-ce82130d-b61c-4dfd-8eaa-5dfd95323005.png">
</p>

Click the `Copy Token to the Clipboard` link, and paste this token in the Jenkins field for `Token`. After doing this paste at the bottom of the UI will be a button for `Save`. Click `Save`. You will be redirected back to the Jenkins Dashboard. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194131300-8e4776e6-dba2-4d5f-94b6-fdc248020a12.png">
</p>

7. If no errors appeared on the screen your configuration should be complete. The last step of the process details that you are now ready to start utilizing your pipeline with Torque. Per the instructions you now need to go build a `Pipeline` in Jenkins. To do this start by navigating to the Jenkins Dashboard and clicking, `New Item`. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194134720-ceda526a-c97d-4e2e-9dc8-5ff019e92990.png">
</p>

8. From this screen you need to provide the pipeline a `Name` and select from one of the templated projects that are available to you. Select `Pipeline`. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194135606-aef28240-0a2c-4912-9892-522a7ad9e408.png">


9. When the UI redirects, in the left nav-pane select `Advanced Project Options`.

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194135982-d832478a-28e9-4301-8e44-8f8af5dfbf57.png">
</p>

10. Here we can provide a `Display Name`. We can also use Community Documentation to implement a sample Sandbox deployment from a Quali Blue print. The documenation reference can be found [here](https://community.qtorque.io/jenkins-67/launching-a-sandbox-from-jenkins-pipeline-277). If you scroll down there is a sample script provided. 

<p align="center">
<img width="785" alt="image" src="https://user-images.githubusercontent.com/8760590/194139045-202b92de-c8e5-4633-907f-e57aade6191d.png">
</p>

This example specifies that a Torque `SpaceName` and `Blueprint` must be specified in this example configuration. If I return to the Torque web interface I can collect those peices of information here. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194139479-7ae0c318-897d-4ae6-b524-47f1f47a7d88.png">
</p>

I will then update my script with that information. 

<p align="center">
<img width="350" alt="image" src="https://user-images.githubusercontent.com/8760590/194140158-f1edd5a8-b8cc-490f-8ed3-9858a7fc8f93.png">
</p>



## FAQ

## References
