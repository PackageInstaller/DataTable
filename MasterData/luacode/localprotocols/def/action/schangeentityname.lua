local SChangeEntityName = dataclass("SChangeEntityName")
SChangeEntityName.ProtocolType = 56
SChangeEntityName.entityId = 0
SChangeEntityName.nameTextId = 0

function SChangeEntityName:Ctor(client)
end

function SChangeEntityName:Marshal(data)
  data.entityId = self.entityId
  data.nameTextId = self.nameTextId
end

function SChangeEntityName:Unmarshal(data)
  self.entityId = data.entityId
  self.nameTextId = data.nameTextId
  return true
end

function SChangeEntityName:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.nameTextId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.nameTextId) = %s. number required.", type(self.nameTextId))
    return false
  end
  return true
end

return SChangeEntityName
