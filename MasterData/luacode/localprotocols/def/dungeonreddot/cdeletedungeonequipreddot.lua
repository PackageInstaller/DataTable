local CDeleteDungeonEquipRedDot = dataclass("CDeleteDungeonEquipRedDot")
CDeleteDungeonEquipRedDot.ProtocolType = 204
CDeleteDungeonEquipRedDot.clientId = 0

function CDeleteDungeonEquipRedDot:Ctor(client)
end

function CDeleteDungeonEquipRedDot:Marshal(data)
  data.clientId = self.clientId
end

function CDeleteDungeonEquipRedDot:Unmarshal(data)
  self.clientId = data.clientId
  return true
end

function CDeleteDungeonEquipRedDot:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CDeleteDungeonEquipRedDot
