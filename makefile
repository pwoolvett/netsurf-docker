build:
	docker build -t pwoolvett/netsurf-fb .
bash:
	docker run --rm -it --privileged --entrypoint bash pwoolvett/netsurf-fb 
run:
	docker run --rm -it --privileged pwoolvett/netsurf-fb 
