include .env
IMAGE=trash-free-potato
CONTAINER=vp-container
MANPREFIX=/usr/local/share/man
SCRIPT=vp-gui.sh

HOME=/home/$(USER)

all:
	@if $(MAKE) -s ask ; then \
		sudo $(MAKE) -s install_users ; \
	else \
		$(MAKE) -s install_user ; \
	fi
.PHONY: all

ask:
	@if [[ -z "$(CI)" ]]; then \
		REPLY="" ; \
		read -p "⚠ Do you wish to install for all USERS? [y/n] > " -r ; \
		if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
			exit 1 ; \
		else \
			exit 0; \
		fi \
	fi
.PHONY: ask

@users = prepare docker_image generate_exec all_user_files clean
@user = prepare docker_image generate_exec user_files clean
include chains.mk

install_users: @users
install_user: @user


prepare prepare@users prepare@user:
	wget -q https://gitlab.com/sjugge/docker/visual-paradigm/-/raw/master/Dockerfile --show-progress

docker_image docker_image@users docker_image@user:
	mkdir -p $(APP_SHARED_DIR)
	chmod +x install.sh
	docker build -t $(IMAGE) .
	docker run -itd --restart unless-stopped --name $(CONTAINER) -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw -v $(APP_SHARED_DIR):/root:rw --privileged $(IMAGE) /bin/bash
	xhost local:docker
	-docker exec -it $(CONTAINER) ./install.sh

generate_exec generate_exec@users generate_exec@user:
	sh executables.sh


clean clean@users clean@user:
	rm -r $(SCRIPT) $(DESKTOP) Dockerfile


all_user_files all_user_files@users:
	mkdir -p $(ALL_USERS_APPLICATION) $(ALL_USERS_EXEC)
	cp -f $(DESKTOP) $(ALL_USERS_APPLICATION)/$(DESKTOP) 
	cp -f $(SCRIPT) $(ALL_USERS_EXEC)/$(EXEC)
	chmod 755 $(ALL_USERS_APPLICATION)/$(DESKTOP)
	chmod 755 $(ALL_USERS_EXEC)/$(EXEC)


user_files user_files@user:
	mkdir -p $(EXEC_PATH) $(DESKTOP_PATH)
	cp -f $(DESKTOP) $(DESKTOP_PATH)/$(DESKTOP) 
	cp -f $(SCRIPT) $(EXEC_PATH)/$(EXEC)
	chmod 755 $(DESKTOP_PATH)/$(DESKTOP) 
	chmod 755 $(EXEC_PATH)/$(EXEC)

uninstall:
	docker container stop $(CONTAINER)
	docker container rm -f $(CONTAINER)
	docker rmi -f $(IMAGE)
	@rm -f $(EXEC_PATH)/$(EXEC)
	@rm -f $(ALL_USERS_EXEC)/$(EXEC)
	@rm -f $(DESKTOP_PATH)/$(DESKTOP)
	@rm -f $(ALL_USERS_APPLICATION)/$(DESKTOP)

.PHONY: all install_user install uninstall


