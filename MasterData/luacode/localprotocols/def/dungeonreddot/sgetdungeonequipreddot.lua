local SGetDungeonEquipRedDot = dataclass("SGetDungeonEquipRedDot")
SGetDungeonEquipRedDot.ProtocolType = 203
SGetDungeonEquipRedDot.clientId = 0

function SGetDungeonEquipRedDot:Ctor(client)
  self.redDotData = {}
end

function SGetDungeonEquipRedDot:Marshal(data)
  data.clientId = self.clientId
  data.redDotData = {}
  for index, value in ipairs(self.redDotData) do
    data.redDotData[index] = {}
    self.redDotData[index]:Marshal(data.redDotData[index])
  end
end

function SGetDungeonEquipRedDot:Unmarshal(data)
  self.clientId = data.clientId
  for index, value in ipairs(data.redDotData) do
    self.redDotData[index] = require("localprotocols.bean.data.equipreddotdata").Create()
    self.redDotData[index]:Unmarshal(data.redDotData[index])
  end
  return true
end

function SGetDungeonEquipRedDot:CheckVariable()
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if type(self.redDotData) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redDotData) = %s. table required.", type(self.redDotData))
    return false
  end
  for index, value in ipairs(self.redDotData) do
    if not value:CheckVariable() then
      return false
    end
  end
  return true
end

return SGetDungeonEquipRedDot
