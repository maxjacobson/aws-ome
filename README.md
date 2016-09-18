## Notes

* installed the aws cli for the first time
* set up an IAM user to configure the cli
* gave that user AdministratorAccess
* requested an ecr login
  `aws ecr get-login --region us-east-1 `
* which returned some code, which I ran, to log in to the registry where I'm going to push my app?
* made the docker image and tagged it and pushed it up to ecr
* ok I went thru the wizard and set up the task definition, service, and cluster, and I believe it's live now, but I can't find it
* aha, I found something... if I drill down a specific running task (and I have 3) then I can see an "External Link" which in this case is <http://54.172.74.239/> -- but I think this is not actually what I want. I'm looking for the load balancer link. The app the tutorial had me build echoes out the hostname, to demonstrate the load balancing of it all. Refreshing several times shows that this IP address is consistently hitting the same hostname...
* aha, I found it, it was listed under DNS name in the load balancers table: <EC2Contai-EcsElast-RXTVU1GDTIX1-757636614.us-east-1.elb.amazonaws.com>

## TODO

* make a trivial change to the existing sinatra app and re-deploy
* add an active-record model to track hit counts

## Notes (again)

* changed the code, re-made the image, and pushed it to the registry
* made a new task definition (manually) and asked it to use the latest-tagged container again...
* now to deploy the change...
* tried to "run task" the task but got this error:
	Run tasks failed
	Reasons : ["RESOURCE:PORTS"]
* Hm... OK so I was able to manually stop the tasks running the old version, which led to it trying to start up tasks using the new version, which failed
* after stopping all 3 tasks, the site is unavailable
* The new ones say: `STOPPED (Essential container in task exited)`
* Status reason 	CannotPullContainerError: Error: image library/docker-sinatra not found
* I think I didn't fully-qualify the container name with the namespace so it can't pull it...?
* welp, this is my first production incident for this sample app...
* OK now I've created a 3rd task definition with the correct image path
* updating the service to use this task definition...
* it seems like I can't "place" the task definitions on instances because they're not a good match because they're already using port 80
* I decided to stop them...
* And restart them (2 of them, the third was just dead?)
* and then go back to the task definition and try to run the task...
* and it's up with my change!! <EC2Contai-EcsElast-RXTVU1GDTIX1-757636614.us-east-1.elb.amazonaws.com> !!
* fist pump
* cycling between 2 host names
