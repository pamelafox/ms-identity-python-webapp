param name string
param location string = resourceGroup().location
param tags object = {}

@description('The log analytics workspace id used for logging & monitoring')
param workspaceId string = ''

resource redisCache 'Microsoft.Cache/Redis@2020-06-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
    sku: {
      capacity: 1
      family: 'C'
      name: 'Basic'
    }
  }
}

resource diagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = if (!empty(workspaceId)) {
  scope: redisCache
  name: redisCache.name
  properties: {
    workspaceId: workspaceId
    metrics: [
      {
        timeGrain: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
  }
}
