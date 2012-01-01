#!/bin/bash

LIBRARY_DIR="lib"
JYTHON_DIR="Lib"
LD_SO_DIR="/etc/ld.so.conf.d/"
OPENCV_CONF="opencv.conf"

function verifyLibrariesDirectory {
    if [ ! -d ${PWD}/$LIBRARY_DIR ]; then
        echo "The OpenCV libraries directory does not exist."
        exit 1
    fi

    if [ ! -d ${PWD}/$JYTHON_DIR ]; then
        echo "The Jython Lib directory does not exist. Please extract it from the sikuli-script.jar file."
        exit 1
    fi    
}

function createLibrariesConfFile {
    
    CONTENT="echo $LD_SO_DIR/$OPENCV_CONF >> ${PWD}/$LIBRARY_DIR"    

    if [ $UID -ne 0 ]; then
        echo "Please, type root's password..."
        CMD=`su -c "$CONTENT"`
    else
        CMD=`$CONTENT`
    fi
    
    if [ $? != 0 ]; then
        echo 'echo "ERROR: The configuration file could not be created."'
        echo $CMD
        exit 1
    else    
        echo 'echo "Configuration file created."'
    fi

    echo 'echo "Updating dynamic library routes."'
    su -c "ldconfig"
	    exit
}

function verifyConfFile {
    if [ ! -f $LD_SO_DIR/$OPENCV_CONF ]; then
        echo 'echo "The configuration file does not exist, it will be created..."'
        `createLibrariesConfFile()`
    else
        echo 'echo "The configuration file already exists."'
    fi
}

`verifyLibrariesDirectory`
`verifyConfFile`
