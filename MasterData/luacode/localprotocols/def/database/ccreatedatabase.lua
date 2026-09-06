local CCreateDataBase = dataclass("CCreateDataBase")
CCreateDataBase.ProtocolType = 301
CCreateDataBase.userId = 0
CCreateDataBase.clientId = 0

function CCreateDataBase:Ctor(client)
end

function CCreateDataBase:Marshal(data)
  data.userId = self.userId
  data.clientId = self.clientId
end

function CCreateDataBase:Unmarshal(data)
  self.userId = data.userId
  self.clientId = data.clientId
  return true
end

function CCreateDataBase:CheckVariable()
  if type(self.userId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.userId) = %s. number required.", type(self.userId))
    return false
  end
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CCreateDataBase
