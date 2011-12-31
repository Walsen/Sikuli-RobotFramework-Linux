#!/bin/bash

export SIKULI_JAR="${PWD}/sikuli-script.jar"
export RF_JAR="${PWD}/robotframework-2.6.3.jar"
#export CLASSPATH=${SIKULI_JAR}:${RF_JAR}

java -cp "robotframework-2.6.3.jar:${SIKULI_JAR}" \
    -Dpython.path="${RF_JAR}/Lib:${SIKULI_JAR}/Lib" \
    org.robotframework.RobotFramework \
    --pythonpath=CalcLib \
    --outputdir=results \
    --loglevel=TRACE \
    ${1}
