# Prueba Tecnica Angel-Castro Samtel

link repo instrucciones: https://github.com/JefryGG1K91/first-filter

## Contar con las siguientes herramientas instaladas.

Sonarqube  
Organización de azure DevOps.  
Docker.  
Azure Agent Pool SelfHosted   
Kubernetes   
Minikube / Hypervisor / Nube con conexión a Azure DevOps   
Utiliza un repositorio del siguiente link del apartado de framework https://docs.docker.com/samples/ 

## Procedimento

1. Descarga los archivos del repositorio elegido.  
2. Instala el framework necesario en caso de no tenerlo. 

### Aplicacion web
Creacion Proyecto Vue.js


    $ npm install -g @vue/cli
    $ npm install -g npm@9.7.1
    $ vue create app-test-angel
    $ cd app-test-angel/
    $ npm run serve

    App running at:
    - Local:   http://localhost:8080/ 

    Ejecutamos el modo producción de Vue
    $ npm run build


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/AngelVueLocal.png)


3. Compila la aplicación luego de pasar el analisis de sonarqube.  

4. Agregar dos escenarios:
    1 - analisis fallido
    2 - analisis exitoso  


### Correr contenedor SonarQube (local)

Se utiliza para evaluar la calidad de codigo (linter) y cobertura de pruebas (CodeCoverage). 

Se levanta el contenedor para no hacer la instalación en el computador.:  
    - Teniendo Docker instalado    
    - Crear carpeta local con permisos de lectura y escritura, para los volumenes persistentes de los contenedores    
    - Bajar el docker-compose.yml de SonarQube y guardarlo en la carpeta creada  
    - Luego ejecutar (desde la ruta de la carpeta)   

        $ docker-compose up
        $ docker ps

    - la interfaz grafica se despliega en local:   http://localhost:9000  
    - Para vincular con la applicacion web (trabajada), crear el archivo: sonar-project.properties   
    - Install sonar-scanner   
    - Run:   

        $  sonar-scanner

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/docker-compose-sonar-terminal.png)

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/AngelSonar.png)


## Crear Dockerfile

5. Genera una imagen de docker y sube la imagen a dockerhub. 

Crear nginx.default.conf  

    $ docker build -t angel-test . 
    $ docker images
    $ docker run -d angel-test 
    $ docker ps
    $ docker exec -it <containerId> sh
    $ docker run -it -p 8080:80 --rm --name angel-test angel-test


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/AngelDocker.png)


7.  Despliega la app a un clúster de kubernetes (minikube o EKS o AKS).

### Infrastructure as code - Cluster Kubernetes

Se configura en el portal de Azure un Grupo de Recursos y se establece un **subscrition_id (Azure se enlace con Terraform)**.    

Resource Group Azure : cloud project   

Para la Infraestructura tenemos los siguientes archivos iniciales:   

    main.tf   
    variables.tf   (variables Terra)
        - region general
        - tags general
        - nombre del grupo de recurso
    terraform.tfvars  

Conexion con el CLI de Azure  

    $ az login 

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/az_login.png)

    $ terraform init


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/terraform_init.png)

    $ terraform plan


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/terraform_plan.png)


    $ terraform apply


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/terraform_apply.png)


#### Backend Remote State

Inicializacion del Backend. Se configura un backend tipo remoto para definir donde terraform almacenara sus archivos de estado y para que varios desarrolladores puedan interactuar con terraform al mismo tiempo.

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/BackendInitialization.png)

Estado del Container

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/estadoContainer.png)


#### Networking

Es necesario tener networking para:   
- Application gateway  
- Container Registry  
- Cluster Kubernetes  (AKS: Azure Kubernetes Service)

Se debe crear una subnet por cada uno. Se crea la Vnet y adentro de ella tres subnets. 

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/subnets.png)

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/networking_success.png)


#### Cantainer Registry y Private Endpoint

Se require un Private Endpoint. Vinculo entre el Azure Container Registry (ACR) y la vnet por el backbone de Azure. 

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/containerRegistrySuccess.png)


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/azurecontainerRegistry.png)


#### Aplication GateWay + IP Publica

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/cluster_AKS.png)


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/load_balancer.png)


#### AKS Azure Kubernetes Service


#### Virtual Machine Azure DevOps + IP Publica



8. Crea un endpoint externo accesible (ingress) para la aplicación  

#### Despliegue de la aplicacion en Kubernetes

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/resources_cluster_terra.png)


#### Agente Azure para Release

El agente esta dentro de la vnet y se conecta con el cluster de kubernetes y permite ejecutar los jobs de los pipelines



#### Pipeline

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/repositoryImages.png)


#### Release


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/AngelVueWeb.png)


![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/credentials.png)

![despliegue localhost](https://github.com/acastroLML/prueba-angel-castro-samtel/blob/main/img-evidences/service_connection.png)


9. Sube al repo en una carpeta environment todos los yaml de k8s.   

 Ver carpeta: Helm



