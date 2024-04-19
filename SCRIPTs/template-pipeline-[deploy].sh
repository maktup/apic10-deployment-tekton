#!/bin/bash

# ****************************************************************************** 
# * - DESCRIPCION:   Shell para ejecucion del 'PipelineRun' par el 'DEPLOY'    *
# * - EJECUCION:     SHELL    								   	 							               *
# * - AUTOR:         Guerra Arnaiz, Cesar Ricardo  		  	 			               *
# * - FECHA:         18/03/2024			      										                 *
# * - VERSION:       1.0									   	    							               *
# * - REQUERIMIENTO: Estar LOGUEADO remotamente a OPENSHIFT.                   *
# *                  Este SCRIPT realizara un CLEAN del HISTORICO de los       *
# *                  recursos: 'PipelineRun', antes de ejecutarse.             *
# ******************************************************************************  
 
clear

vCURRENT_DATE=`DATE +%Y%m%d%H%M%S`
vTRANSACTION="$vCURRENT_DATE - [INFO]": 
vWAIT_TIME_2=2
vWAIT_TIME_4=4

vNOMBRE_SHELL="3_template-pipeline-[deploy].yaml"
vNAMESPACE="temp-3";

echo "${vTRANSACTION} ******************** [START] ********************"
echo "${vTRANSACTION} EXECUTING SCRIPT..."

oc delete pipelinerun --all -n ${vNAMESPACE}
sleep ${vWAIT_TIME_4}

cat ${vNOMBRE_SHELL}
oc create -f ${vNOMBRE_SHELL}

echo "${vTRANSACTION} ********************** [END] *********************"
echo "${vTRANSACTION} Waiting: [${vWAIT_TIME_2}] seconds to close..."
sleep ${vWAIT_TIME_2}

exit
