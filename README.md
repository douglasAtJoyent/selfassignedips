# selfassignedips

This is a set of tests that automate most of the test plan listed here:
https://docs.google.com/document/d/1DbkbdCujWAK1DWAT_HSM2VGRLbgnqYkAzZvVKsVU7Lw/edit

Steps to setup and run these tests :
1. get the image : 
   docker pull douglasatjoyent/selfassignedips
2. Create an instance
  docker create -it --name=setup douglasatjoyent/selfassignedips
3. Copy the public key and add it to your user
  docker cp setup:/root/.ssh/sdc_docker_jmeter_id_rsa.pub .
4. Add the key to your account
  triton key add -n jmeter sdc_docker_jmeter_id_rsa.pub
5. Start the image, there is a script that has to be executed in order to finish the setup
   docker start -ia setup
6. run the script sdc-docker-setup.sh, follow the prompts, this will setup your image.
7. exit and commit the image.
   docker commit setup douglasatjoyent/selfassignedips
8. Create an enviroment file, this will be reffered to as env.txt.

OUTPUT_DIRECTORY - the directory where the output 
SDC_KEY_NAME     - The name of the registered key
SDC_USERNAME     - The account name..
SDC_ACCOUNT      - This is the name of the registered name of the key
PRIVATE_KEY      - The path to the key on the VM - for this it should be /root/.ssh/sdc_docker_jmeter_id_rsa.pub
DOCKER_CERT_PATH - The certification path, this can be gotten from the result of the sdc-docker-setup.sh
DOCKER_HOST      - The host name of docker
SDC_HOST         - The host name of the sdc host, not the URL but the HOST

Here is an example of what the file should look like : 
 
OUTPUT_DIRECTORY=/selfassignedips/output
SDC_KEY_NAME=jmeter.user
SDC_ACCOUNT=douglas.anderson
PRIVATE_KEY=/root/.ssh/sdc_docker_jmeter_id_rsa
DOCKER_CERT_PATH=/root/.sdc/docker/douglas.anderson
DOCKER_HOST=10.88.88.6
SDC_HOST=10.88.88.5

9. Create a new image and run the test
   docker run -it --env-file=env.txt douglasatjoyent/selfassignedips bash /selfassignedips/runTest.sh
