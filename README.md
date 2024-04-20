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


-------------------------------------------------------------------------------------


## 'IMPORTANT':

## 'STEP#A':
- Download the **APICTOOLKIT** file called: 'toolkit-linux.tgz' & place it in the path: **C:\IBM\APIC**
- Next to creating the file: '**dockerfile**' with this content:

        FROM ubuntu:20.04
        RUN apt-get update
        RUN apt-get install -y curl
        RUN apt-get install coreutils
        COPY toolkit-linux.tgz /app/
        RUN tar -xzvf /app/toolkit-linux.tgz -C /app  
        RUN mv /app/apic-slim /app/apic  
        RUN rm /app/toolkit-linux.tgz
        ENV APIC_TOOLKIT /app
        ENV PATH="$PATH:$APIC_TOOLKIT"
        RUN $APIC_TOOLKIT/apic version --accept-license
        CMD ["tail", "-f", "/dev/null"]

- To CREATE the **IMAGE** locally, execute:

         $ docker login docker.io
            Username: XXX
            Password: XXX
            Login Suceeded
     
         $ cd C:\IBM\APIC
         $ docker build -t apic-toolkit-image .
         $ docker images 
            apic-toolkit-image        latest   0eed61e4d311   12 days ago    272MB 
         $ docker tag apic-toolkit-image maktup/apic-toolkit-image:latest
         $ docker images 
            maktup/apic-toolkit-image latest   0eed61e4d311   12 days ago    272MB


## 'STEP#B':
- Create the **IMAGE-REGISTRY** in **DOCKER HUB**.
- To **UPLOAD** the **IMAGE** to the **IMAGE-REGISTRY**:
      $ docker push docker.io/maktup/apic-toolkit-image:latest
  
- The **ROUTE** generated in the **IMAGE REGISTRY** in this case is:
**'maktup/apic-toolkit-image:latest'**

 
## 'STEP#C':
- Within **OPENSHIFT** the **NAMESPACE** where we will work in this case: '**temp-3**'.
- Within **OPENSHIFT** generate the **IMAGE-STREAM** based on the **IMAGE** path:
      $ oc import-image apic-toolkit-image --from=docker.io/maktup/apic-toolkit-image:latest --confirm -n temp-3
  
  
## 'STEP#D':
- Get the generated **IMAGE-STREAM**:
      $ oc get imagestreams apic-toolkit-image -n temp-3
        default-route-openshift-image-registry.apps.tarkin.coc-ibm.com/temp-3/apic-toolkit-image  (PUBLIC IMAGE REPOSITORY)
        image-registry.openshift-image-registry.svc:5000/temp-3/apic-toolkit-image                 (IMAGE REPOSITORY)*
- Reuse the generated **IMAGE-STREAM** in **OPENSHIFT PIPELINE**.



LINKS REFERENCIA:
----------------
*https://github.com/ibm-apiconnect/example-toolkit-scripts/tree/master/bash
https://github.com/khongks/apic-scripts-public*

