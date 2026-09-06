local LocalProtocolManager = {}

function LocalProtocolManager.CreateProtocol(protocolName)
  return require("localprotocols.process." .. protocolName).Create()
end

function LocalProtocolManager.GetProtocolDef(protocolName)
  return require("localprotocols.process." .. protocolName)
end

function LocalProtocolManager.CreateBean(beanName)
  return require("localprotocols.bean." .. beanName).Create()
end

function LocalProtocolManager.GetBeanDef(beanName)
  return require("localprotocols.bean." .. beanName)
end

return LocalProtocolManager
