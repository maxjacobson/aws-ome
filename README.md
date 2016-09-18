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
* aha, I found it, it was listed under DNS name in the load balancers table: EC2Contai-EcsElast-RXTVU1GDTIX1-757636614.us-east-1.elb.amazonaws.com

## TODO

* make a trivial change to the existing sinatra app and re-deploy
* add an active-record model to track hit counts
