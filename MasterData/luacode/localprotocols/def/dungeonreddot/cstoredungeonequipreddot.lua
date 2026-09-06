local CStoreDungeonEquipRedDot = dataclass("CStoreDungeonEquipRedDot")
CStoreDungeonEquipRedDot.ProtocolType = 201
CStoreDungeonEquipRedDot.clientId = 0

function CStoreDungeonEquipRedDot:Ctor(client)
  self.redDotData = require("localprotocols.bean.data.equipreddotdata").Create()
end

function CStoreDungeonEquipRedDot:Marshal(data)
  data.clientId = self.clientId
  data.redDotData = {}
  self.redDotData:Marshal(data.redDotData)
end

function CStoreDungeonEquipRedDot:Unmarshal(data)
  self.clientId = data.clientId
  self.redDotData = require("localprotocols.bean.data.equipreddotdata").Create()
  self.redDotData:Unmarshal(data.redDotData)
  return true
end

function CStoreDungeonEquipRedDot:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if not self.redDotData:CheckVariable() then
    return false
  end
  return true
end

return CStoreDungeonEquipRedDot
