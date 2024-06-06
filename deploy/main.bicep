// Parameters
@description('Specifies the name of the Azure Container Apps Job.')
param name string

@description('Specifies the location.')
param location string = resourceGroup().location

@description('Specifies the resource tags.')
param tags object = {}

@description('Specifies the resource id of the Azure Container Apps Environment.')
param environmentId string

@description('Specifies a workload profile name to pin for container app execution.')
param workloadProfileName string = 'Consumption'

@description('Specifies the maximum number of retries before failing the job.')
param replicaRetryLimit	int = 1

@description('Specifies the maximum number of seconds a Container Apps job replica is allowed to run.')
param replicaTimeout	int = 60

@description('Specifies the container environment variables.')
param env array = [
  {
    name: 'DOMAIN'
    value: 'example.com'
  }, {
    name: 'EMAIL'
    value: 'admin@example.com'
  }, {
    name: 'KEYVAULT'
    value: 'mykeyvaultname'
  }
]

@description('Specifies the container image.')
param containerImage	string

@description('Specifies the container name.')
param containerName	string = 'main'

@description('Specifies the Required CPU in cores, e.g. 0.5 for the first Azure Container Apps Job. Specify a decimal value as a string. For example, specify 0.5 for 1/2 core.')
param cpu string = '0.25'

@description('Specifies the Required memory in gigabytes for the second Azure Container Apps Job. E.g. 1.5 Specify a decimal value as a string. For example, specify 1.5 for 1.5 GB.')
param memory string = '0.5Gi'

resource job 'Microsoft.App/jobs@2023-04-01-preview' = {
  name: toLower(name)
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    configuration: {
      scheduleTriggerConfig: {
        cronExpression: '0 0 1 * *'
      }
      replicaRetryLimit: replicaRetryLimit
      replicaTimeout: replicaTimeout
      triggerType: 'Schedule'
    }
    environmentId: environmentId
    template: {
      containers: [
        {
          env: env
          image: containerImage
          name: containerName
          resources: {
            cpu: json(cpu)
            memory: memory
          }
        }
      ]
    }
    workloadProfileName: workloadProfileName
  }
}
