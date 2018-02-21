rm -rf ${OUTPUT_DIRECTORY}
rm results.jtl

if [[ $DOCKER_TLS_VERIFY ]]; then
    jmeter \
    -Dhost=${SDC_URL} \
    -DDOCKER_HOST=${DOCKER_HOST} \
    -Dcert=${DOCKER_CERT_PATH} \
    -Dscript=${SCRIPT_LOCATION} \
    -Dkey=${PRIVATE_KEY} \
    -Daccount=${SDC_ACCOUNT} \
    -Dusername=${SDC_USERNAME} \
    -DdockerPath=`which docker` \
    -DThreads=${THREADS} \
    -Dtls=false \
    -n \
    -t /selfassignedips/BasicTests.jmx \
    -e \
    -l results.jtl \
    -o ${OUTPUT_DIRECTORY};
else
    jmeter \
    -Dhost=${SDC_HOST} \
    -DdockerHost=${DOCKER_HOST} \
    -Dcert=${DOCKER_CERT_PATH} \
    -Dscript=/selfassignedips/gen_key.sh \
    -Dkeyfile=${PRIVATE_KEY} \
    -Daccount=${SDC_ACCOUNT} \
    -Dusername=${SDC_USERNAME} \
    -DdockerPath=`which docker` \
    -DThreads=${THREADS} \
    -Dtls=true \
    -n \
    -t /selfassignedips/BasicTests.jmx \
    -e \
    -l results.jtl \
    -o ${OUTPUT_DIRECTORY};
fi
