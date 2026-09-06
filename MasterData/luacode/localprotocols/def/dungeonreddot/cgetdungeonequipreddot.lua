local CGetDungeonEquipRedDot = dataclass("CGetDungeonEquipRedDot")
CGetDungeonEquipRedDot.ProtocolType = 202
CGetDungeonEquipRedDot.clientId = 0

function CGetDungeonEquipRedDot:Ctor(client)
end

function CGetDungeonEquipRedDot:Marshal(data)
  data.clientId = self.clientId
end

function CGetDungeonEquipRedDot:Unmarshal(data)
  self.clientId = data.clientId
  return true
end

function CGetDungeonEquipRedDot:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CGetDungeonEquipRedDot
