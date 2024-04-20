# DEPLOYMENT AUTOMATION WITH: 'IBM APIC TOOLKIT & OPENSHIFT PIPELINE (TEKTON)': 

## 1. CONTEXT:
This DEMO allows the INTEGRATION between IBM APICTOOLKIT & OPENSHIFT PIPELINE (TEKTON), with the objetive of providing AUTOMATION for the deployments of: APIs, etc. created in IBM APIC v10s.


## 2. ARCHITECTURE:
The following ARCHITECTURE shows how the different RESOURCES used within the OPENSHIFT cluster and the interaction with the AUTOMATION of the APIs with APICTOOLKIT.

![alt text](https://github.com/maktup/apic10-deployment-tekton/blob/main/IMAGEN/Automatizacion%20Despliegues%20APIC%20(Arquitectura).jpg?raw=true)


## 3. REQUIREMENTS:

- For **AUTOMATIC** deployment of APIC components using **OPENSHIFT PIPELINE**, it is not the same as working **TEKTON** directly.
- When working with OPENSHIFT PIPELINE you have to consider managing IMAGES that support the commands to be used, in this case the commands from: APICTOOLKIT.
- There is no directly DOCKERIZED IMAGE that supports APICTOOLKIT, which is why the IMAGE had to be created: 'https://hub.docker.com/repository/docker/maktup/apic-toolkit-image/general'.
- The PROCEDURE for these scenarios is:

*A. CREATE THE DOCKER IMAGE BASED ON THE APICTOOLKIT DOWNLOADED FROM THE APIC PLATFORM.*

*B. UPLOAD THE LOCALLY GENERATED DOCKER IMAGE TO AN IMAGE REGISTRY (IN THIS CASE DOCKERHUB).*

*C. BASED ON THE IMAGE IN THE IMAGE REGISTRY, GENERATE AN IMAGE-STREAM IN OPENSHIFT.*

*D. THIS GENERATED IMAGE-STREAM IS THE ONE THAT WILL BE REUSED FOR OPENSHIFT PIPELINE.*
