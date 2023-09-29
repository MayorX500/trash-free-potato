#!/bin/bash

set -o allexport
source ./.env
set +o allexport

IMAGE=trash-free-potato
CONTAINER=vp-container
SCRIPT=vp-gui.sh

write_executable () {
	
	echo -ne "#!/bin/bash
xhost local:docker && \
docker exec -it \
  $CONTAINER \
  Visual_Paradigm


" > ./$SCRIPT


	EX_PATH=$EXEC_PATH/$EXEC
	if [ ! -f "$EX_PATH" ]; then
		EX_PATH=$ALL_USERS_EXEC/$EXEC
	fi

	echo -ne "[Desktop Entry]
Name=$APP_NAME 17.0
StartupWMClass=vp-container
Comment=UML stuff.
GenericName=$APP_NAME
Exec=/usr/local/bin/devour $EX_PATH %U
Icon=https://online.visual-paradigm.com/images/press-kit/logo-blueprint.png
Type=Application
Categories=Network;
Terminal=true
StartupNotify=true
MimeType=text/x-python;

" > ./$DESKTOP

}

check_devour () {

	git clone https://github.com/salman-abedin/devour.git && cd devour && sudo make install && cd .. && rm -rf devour
}


check_devour
write_executable
echo $EX_PATH
