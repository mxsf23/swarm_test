# Deploy test app via docekr swarm in YaCloud

This is just test.

Packer+Terraform+some bash

Just fill in correct creds in provider settings, packer variables and put keys in  ```files```  folder.

Run:
``````
./deploy.sh 
``````

Notes:

1. Read YaCloud docs for correct packer configuration
2. Worker nodes still are deployed with external addresses (someday I'll fix it :) 
