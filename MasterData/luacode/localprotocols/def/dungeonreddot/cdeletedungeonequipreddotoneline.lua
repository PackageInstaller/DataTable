local CDeleteDungeonEquipRedDotOneLine = dataclass("CDeleteDungeonEquipRedDotOneLine")
CDeleteDungeonEquipRedDotOneLine.ProtocolType = 205
CDeleteDungeonEquipRedDotOneLine.clientId = 0
CDeleteDungeonEquipRedDotOneLine.roleKey = 0
CDeleteDungeonEquipRedDotOneLine.equipKey = 0

function CDeleteDungeonEquipRedDotOneLine:Ctor(client)
end

function CDeleteDungeonEquipRedDotOneLine:Marshal(data)
  data.clientId = self.clientId
  data.roleKey = self.roleKey
  data.equipKey = self.equipKey
end

function CDeleteDungeonEquipRedDotOneLine:Unmarshal(data)
  self.clientId = data.clientId
  self.roleKey = data.roleKey
  self.equipKey = data.equipKey
  return true
end

function CDeleteDungeonEquipRedDotOneLine:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if type(self.roleKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.roleKey) = %s. number required.", type(self.roleKey))
    return false
  end
  if type(self.equipKey) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.equipKey) = %s. number required.", type(self.equipKey))
    return false
  end
  return true
end

return CDeleteDungeonEquipRedDotOneLine
