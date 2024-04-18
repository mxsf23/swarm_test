# Deploy test app via docker swarm in YaCloud

This is just test.

Packer+Terraform+some bash

Just fill in correct creds in provider settings, packer variables and put keys in  ```terraform/files```  folder.

Run:
``````
./deploy.sh 
``````

Notes:

1. Read YaCloud docs for correct packer configuration
2. Worker nodes are still deployed with external addresses (someday I'll fix it :)
3. By default - user ```ansible``` is created. And app files are placed in its home folder.   
