# DevOps Coding Challenge

Welcome to our DevOps coding challenge! This challenge is designed to assess your skills in Docker, CI/CD, AWS, and Observability. You will be provided with 4 unique challenges and your goal is to choose 3 and try to complete as many of their tasks as you can or as is applicable. While you don't have to complete every challenge, you should be able to speak to a process for how to resolve each challenge in the follow-up technical screening.  Ideally, you shouldn't spend more than 5 hours on this challenge. If you find that the exercise requires more time, feel free to submit your exercise with pseudo-code and descriptions of what you planned to do but couldn’t complete.  This is a new process for us and we want to hear your feedback/questions if you have them.

## The Story

You are approached by a software developer named Spruce Bingsteen who is working on a new web application to revolutionize the way we experience the beasts in the Bible. Spruce is looking for help with the DevOps side of the application. He has provided you with a repository that contains the source code along with some commands to run the service locally. Spruce is stoked because he has made his first Dockerfile but he is complaining that it takes long to build everytime he makes a change. He has asked you to help with the following:

## Challenges - Choose 3

Please only select 3 of the following challenges. 
1. **Docker**: You will find a Dockerfile in the root directory of this repository. The Dockerfile is poorly formatted and users are complaining that it takes too long to build the Docker image every time they make a change. It appears all the dependencies are being installed every time there is a change to any file in the repo.  
Tasks:
    - Optimize the Dockerfile to reduce the build time and size of the Docker image.
    - Is there anything that wouldn't function as expected in the Dockerfile?
    - Be ready to explain your changes and why you made them.

2. **CI/CD**: Create a github actions workflow(s) for this repository.
Tasks:
    - Can you automate (choose at least one):
        - The build and push of the Docker image to the Github Container Registry?
        - The deployment of the application to AWS?
        - The observability setup for the application?
    - Are there any other automations you can think of that would be useful for this application?
    - Can you show what branching strategy and development workflow you would choose for this application? (assume there will be anywhere from 5-10 developers working in this repository)

3. **AWS Deployment**: Deploy the application to AWS. You can choose to use any AWS service you want to deploy the application but you should aim to land on a containerized solution (not just a static site because thats not what Spruce was looking for). NOTE: You will need to use your own AWS account for this task.  We will provide you with an additional $25 to cover any hosting fees for this challenge. If your hosting fees exceed $25, you are headed down the wrong path.
Tasks:
    - Be ready to explain your deployment process and why you chose the AWS service(s) you did.
    - While using an IAC tool is not required, the process for deploying the application should be well defined and repeatable enough for Spruce to be able to repeat the process.
    - You should be able to provide access to the hosted application, which can be achieved without the need for a unique domain or Route 53 entries. It could simply be an IP address or the generated AWS URL.
    - Once deployed, provide instructions for how updates to the application would be deployed by Spruce.

4. **Observability**: Set up observability for the application. This could include application logs, metrics, and traces. We strongly recommend you use New Relic for this challenge as that is the tool we are currently using. Be prepared to show how you would use the observability tools to debug an issue with the application. Tasks:
    - The process for setting up observability should be well defined and repeatable.
    - Can you use any IAC tools to configure your dashboards and settings?
    - The observability setup should be able to provide useful information for debugging issues with the application.
    - You can set up observability for the application locally or in AWS.

## Submission

Please fork this repository, make your changes, and send an email to tucker.hayden@bibleproject.com and david.carroll@bibleproject.com with the a link to your repo when you are finished (if it is a private repo please add the users [axesilo](https://github.com/axesilo) and [Tjhayhay](https://github.com/Tjhayhay). In your technical screening interview you will be expected to provide a brief explanation of your work.  Again, This is a new process for us and we want to hear your feedback/questions if you have them. So please feel free to reach out if you are feeling stuck. 

Good luck!

## To run the application locally

First, run the server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

--------------------------------------------------------------------------------------------------------------

# Hi Spruce Bingsteen!

Thank you for reaching out; it's great to connect with you!

I've examined the repository and the provided Dockerfile for the Bible Beasts web app. In response to your concerns, I've made significant progress. The Dockerfile has been optimized to streamline the build process, ensuring enhanced efficiency. Additionally, I successfully deployed the application on AWS ECS Fargate and implemented GitHub actions for continuous integration, automatically integrating new code merged into the main branch.

Feel free to review the comments below at your convenience. I am eager to collaborate further to enhance the development experience. Should you have any questions or need assistance, please don't hesitate to reach out.

Best Regards,  
**Josh Becker**




# **Docker Containerization Optimization** | TASK 1  

## **Addressing Extended Build Times**  

**Changes made to optimize the Dockerfile:**  
1. Specificity with regard to a specific and recent version of node, 18 is stable and alpine is smaller.  
2. Updated workdir to usr/src/app as best practice for next js apps  
3. Added a line to copy only necessary files needed for dependency installation  
4. Added a command that will clean up / remove unnecessary files in order to reduce image size  
	RUN rm -rf node_modules && npm prune --production  

## **RESULTS:**  
• Our initial Docker Image on ECR on push was 677.79 MB  
• With the new Dockerfile changes implemented, the size was reduced to 444.33 MB.  
• OUTCOME: 34.44% reduction in size.  

• Our initial Docker Image on local machine was 1.74 GB  
• With the new Dockerfile changes implemented, the size was reduced to 1.19 GB  
• OUTCOME: 31.6% reduction in size.  

Build time was also reduced by a similar proportion.  




# **AWS ECS Deployment with Containerization** | TASK 3  

## **Comments about choice of technologies for deployment:**  
- Due to our time restrictions with this deployment, being only 5 hours allotted - it was important to keep our architecture simple and easy to maintain.  

## **10,000 ft view**  
- Containerized our Application using Docker  
- Pushed the Container to AWS ECR (We can use Github Container Repository moving forward if you prefer)  
- Deployed via ECS Cluster using AWS Fargate  

## **Deployed our application on AWS ECS Fargate with Containerization via Docker.**     
Why AWS Fargate? AWS Fargate is a great solution for our application because:  
• No Cluster Management: Fargate eliminates the need to manage EC2 Instances clusters for containers.  
• Seamless Scaling: No need to provision resources; scaling is based on defined app requirements.  
• Integration with Amazon ECS: Specify app requirements and policies, upload to Amazon ECS.  
• Security: AWS lacks built-in container security mechanisms; dedicated virtual machines are preferred.  
• Lowering Costs: Fargate manages infrastructure, reducing overall application costs.  
  
## **Live IP address of the deployment:**     
http://13.52.61.169:3000/   



**Summary of the steps to perform an initial AWS ECS Deployment with Docker via AWS ECR**  


**1. Create Repository on AWS ECR for our Docker Image (public or private, I created a private one)**  
Name: bp-bible-beasts-ecr-repository-private


**2. Create Docker Image**   
• Authenticate / Configure AWS in terminal via AWS CLI (or change permissions in ECR repo, less secure)   
  - If issues with aws configure - install and use amazon-ecr-credential-helper to overcome the 2,500 character limit authentication in terminal issue.   
    https://github.com/awslabs/amazon-ecr-credential-helper  
Then perform the following commands / tasks -  
• docker build -t bp-bible-beasts-ecr-repository-private .  
• docker tag bp-bible-beasts-ecr-repository-private:latest 661859176969.dkr.ecr.us-west-1.amazonaws.com/bp-bible-beasts-ecr-repository-private:latest  
• test the image locally  |  docker run -dp 127.0.0.1:3000:3000 bp-bible-beasts-ecr-repository-private  
• You should now be able to visit the app @ http://127.0.0.1:3000  
• docker push 661859176969.dkr.ecr.us-west-1.amazonaws.com/bp-bible-beasts-ecr-repository-private:latest  
• You should now see your image on ECR if you refresh your repository screen  


**3. Create a new ECS Cluster:**  
Name: bp-bible-beasts-ecs-fargate  


**4. Create a Task Definition:**  
Name: bp-bible-beasts-ecs-fargate-task-definition  
Linux/X86_64  |  1 vCPU  |  3 GB Memory  |  ecsTaskExecutionRole  
Network Mode: awsvpc (has to be vpc for fargate)  
Enter Container Information -  
Container Name: bp-bible-beasts-ecr-repository-private  
Container Image URI: 661859176969.dkr.ecr.us-west-1.amazonaws.com/bp-bible-beasts-ecr-repository-private:latest  
Set Port Mapping Container Port 80 TCP HTTP  


**5. Create Service**   
Application Type: Service (as apposed to a single task, this will make it easier for Continuous Deployment)  
Family: bp-bible-beasts-ecs-fargate-task-definition  
Service Name: bp-bible-beasts-ecs-fargate-service  
Desired Tasks: 1 (you can select as many as required, We can add auto scaling later)  
Network: Default VPC or create one  
Security Group: (Create new) bp-bible-beasts-ecs-fargate-sg   
- Set Inbound Rules: All TCP Traffic from Anywhere and HTTP TCP 80 from Anywhere  
Public IP: Yes / Turned On  
Load Balancing: No (Off for now... would love to have several instances and have ALB with autoscaling in future)  


## **Notes about suggested future improvements**   
I would like to revisit this and implement a load balancer to handle and distribute traffic. For example, we can set a minimum of 3 instances or however many appropriate, and set up autoscaling rules based on number of requests or if the average CPU usage exceeds 10% or some appropriate figure. This will be a great solution to increase our scalability and availability.  

*For now we have a functional delivery, however in due time, and as we continue to grow - implementing these suggested improvements will become more and more important in order to best handle the increased load and traffic.

## **Notes about Load Balancing with example:**  
- Here is a link to an nginx docker container that I launched from AWS ECR on ECS Fargate that is running 3 instances with a load balancer 
• http://nginx-load-balancer-1865082610.us-west-1.elb.amazonaws.com/  
- The traffic is distributed to three different instances, making it capable of handling heavy traffic.
- When we have the availability of time, let's revisit this conversation about these deployment improvements to our infrastructure that will make it more scalable to handle more users by using more sophisticated techniques. This will include multiple security groups to control traffic and allow us to easily implement an SSL certificate and not have to update domains via Route 53 as much of this will be streamlined.


**Diagram of what I am proposing:**  
  
![bp-bible-beasts-infrastructure](https://github.com/joshuabecker91/Bible-Beasts-Project/assets/98496684/229a943d-d247-4e71-9fe7-6ec6401763f7)
  

   
## **Notes about updating the application**  
If you wanted to UPDATE the application MANUALLY, this is how (I've created the Github Actions to automate this, which you will see below):    
1. Build the updated Docker image that you want to deploy    
2. Push the latest version Docker image with appropriate tag to ECR    
3. When you are ready to go live with the new image:    
	A. Update Task Definition (make a new revision) with the new URI that has the updated tag    
	B. Update the Service to point to the new revised task definition   
* ECS will automatically turn off the running instance(s) on Fargate that are running the old container image and spin up a new one(s) with the new container image.  


**Comments and Ideas:**  
We can create a separate staging branch as part of our workflow, even with its own ecs cluster as well (if that would be helpful).  

**We could have both:**  
- a build / source version deployed for the test team (or w/ automated test pipeline)  
- and the live production version   


# **CI / CD** | TASK 2  


## **Continuous Integration**  
**Automation of the build and push of the Docker images to AWS ECR -**    
• I went ahead and set up the main branch on GitHub Repo to be Continuously Integrated.  
• I've set up a GitHub workflow via .yml file to automate this process. Any time a pull request is pushed it will run though the .yml file and docker build to check for errors, and inform you whether or not it can be merged (triggering next step, docker build and ECR push).  
• Any time you change the main branch of your github repository, a new docker image is created and pushed to AWS ECR!  
- Versioning Starts at 1000 and counts up automatically based on the activity in the Git Repository  
- If you run into an issue, you can roll back to the last stable version # by simple updating the task definition's assigned container image's tag and update the service to point to the new task definition's revision.  

**Deployment -**  
Any time that you want to go live with the latest version you just simply:  
	A. Update Task Definition (make a new revision) with the new URI that has the updated tag  
	B. Update the Service to point to the new revised task definition  
If you have any issue and need to roll back you can easily revert the change by doing Steps A & B again by selecting the rollback image you want.  
* ECS will automatically turn off the running instance(s) on Fargate that are running the old container image and spin up a new one(s) with the new container image.  


## **Continuous Deployment**  
**Automation of the deployment on AWS**   
With a bit more time I would be able to tackle adding the functionality for Automated Continuous Deployment.   
*What I would do to complete this:   
Add GitHub actions in the .yml file that will automatically update the task definition and service on AWS for our AWS ECS Cluster    
This will take care of continuous deployment for you. We actually want to update the existing task definition and service, or we can create new and delete the previous.  

Something like this would assist -    
GitHub Action: ECS Deploy Action.    
Use Case: Deploying a Docker container to ECS Fargate.   
GitHub Marketplace: aws-actions/amazon-ecs-deploy-task-definition   

or  
GitHub Action: GitHub Actions for AWS:    
Use Case: General AWS interactions and ECS deployments.   
GitHub Marketplace: aws-actions/actions   


## **Notes on Versioning**   
Naming convention idea for workflow -   
bp-project-name-team-versionORtag  
- bp for bible project
- with this naming convention, you will know who was working on what and when making it easier to identify the root cause via debugging.  

With the continuous integration that was set up, these images are generated and pushed to ECR every time main branch is updated, so we will be able to roll back to any specific moment in time and have a lot of data to assist in finding issues if something went wrong and what caused it.  
We would have: The project, team, version / tag, as well as a timestamp.  

Periodically we can determine a stable version that we are satisfied with and make note of that release with a major naming convention like 10.0.0  


## **Notes on other CI / CD ideas**   
Time permitting, I would be interested in implementing other GitHub Actions, such as:  
• Observability - Setting up New Relic and automating  

GitHub Actions Workflow:   
Create a .github/workflows/new-relic-deployment.yml file for your GitHub Actions workflow. Below is a sample workflow:  
      - name: Notify New Relic  
        run: |  
          curl -X POST "https://api.newrelic.com/v2/applications/APPLICATION_ID/deployments.json" \  
          -H "Api-Key:${{ secrets.NEW_RELIC_API_KEY }}" \  
          -d "deployment[revision]=${{ github.sha }}" \  
          -d "deployment[changelog]=${{ github.event_name }}: ${{ github.sha }}"  


GitHub Workflow Dispatch Action:   
Use Case: Triggering workflows manually when needed.  
GitHub Marketplace: peter-evans/workflow-dispatch  

Cache Action:   
Use Case: Caching dependencies to speed up build times.  
GitHub Marketplace: actions/cache  

Environment Cleanup Action:    
Use Case: Cleaning up resources or environments after deployment.  
GitHub Marketplace: softprops/action-gh-release  

Linters and Testing Actions:  
Use Case: Running linters, tests, and ensuring code quality.  
GitHub Marketplace: Varies based on the programming language and tools you use.  
