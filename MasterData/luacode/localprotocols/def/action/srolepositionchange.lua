local SRolePositionChange = dataclass("SRolePositionChange")
SRolePositionChange.ProtocolType = 3
SRolePositionChange.entityId = 0
SRolePositionChange.posX = 0
SRolePositionChange.posY = 0

function SRolePositionChange:Ctor(client)
end

function SRolePositionChange:Marshal(data)
  data.entityId = self.entityId
  data.posX = self.posX
  data.posY = self.posY
end

function SRolePositionChange:Unmarshal(data)
  self.entityId = data.entityId
  self.posX = data.posX
  self.posY = data.posY
  return true
end

function SRolePositionChange:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.posX) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posX) = %s. number required.", type(self.posX))
    return false
  end
  if type(self.posY) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.posY) = %s. number required.", type(self.posY))
    return false
  end
  return true
end

return SRolePositionChange
