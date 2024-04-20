# DEPLOYMENT AUTOMATION WITH: 'IBM APIC TOOLKIT & OPENSHIFT PIPELINE (TEKTON)': 

## 1. CONTEXT:
This DEMO allows the INTEGRATION between IBM APICTOOLKIT & OPENSHIFT PIPELINE (TEKTON), with the objetive of providing AUTOMATION for the deployments of: APIs, etc. created in IBM APIC v10s.


## 2. ARCHITECTURE:
The following ARCHITECTURE shows how the different RESOURCES used within the OPENSHIFT cluster and the interaction with the AUTOMATION of the APIs with APICTOOLKIT.

![alt text](https://github.com/maktup/apic10-deployment-tekton/blob/main/IMAGEN/Automatizacion%20Despliegues%20APIC%20(Arquitectura).jpg?raw=true)


## 3. REQUERIMIENTOS:
_ Para el despligue AUTOMÁTICOS de componentes de APIC utilizando OPENSHIFT PIPELINE, no es igual que trabajar TEKTON directamente.
_ Cuando se trabaja con OPENSHIFT PIPELINE se tiene que considerar el manejar IMAGENES que soporten los comandos que se vayan a utilizar, en este caso los comandos de: APICTOOLKIT.
_ No existe una IMAGEN directamente DOCKERIZADA que soporte APICTOOLKIT, debido a ello se ha tenido que crear la IMAGE: 
  'https://hub.docker.com/repository/docker/maktup/apic-toolkit-image/general'.

_ El PROCEDIMIENTO para estos escenarios es:  
  A. CREAR LA IMAGE DOCKER EN BASE AL APICTOOLKIT DESCARGADO DE LA PLATAFORMA DE APIC.
  B. SUBIR LA IMAGE DOCKER GENERADA LOCALMENTE A UN IMAGE REGISTRY (EN ESTE CASO DOCKERHUB).
  C. EN BASE A LA IMAGE EN EL IMAGE REGISTRY, GENERAR EN OPENSHIFT UN IMAGE-STREAM.
  D. ESTE IMAGE-STREAM GENERADO ES EL QUE SE REUTILIZARÁ PARA OPENSHIFT PIPELINE.

| NAME |  DETAIL  |
| ------------ | ------------ |
| dummy_csm_microservice | consists of the DIRECTORY of the ACE12 project, with the MICROSERVICE SOURCES. |
| scripts | contains the YAML scripts to be installed ORDERLY, for the construction of the DEVOPs flow with TEKTON. |
