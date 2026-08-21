-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/dungeonreddot/cdeletedungeonequipreddotoneline.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDeleteDungeonEquipRedDotOneLine = dataclass("CDeleteDungeonEquipRedDotOneLine")
CDeleteDungeonEquipRedDotOneLine.ProtocolType = 205
CDeleteDungeonEquipRedDotOneLine.clientId = 0
CDeleteDungeonEquipRedDotOneLine.roleKey = 0
CDeleteDungeonEquipRedDotOneLine.equipKey = 0
CDeleteDungeonEquipRedDotOneLine.Ctor = function(self, client)
  -- function num : 0_0
end

CDeleteDungeonEquipRedDotOneLine.Marshal = function(self, data)
  -- function num : 0_1
  data.clientId = self.clientId
  data.roleKey = self.roleKey
  data.equipKey = self.equipKey
end

CDeleteDungeonEquipRedDotOneLine.Unmarshal = function(self, data)
  -- function num : 0_2
  self.clientId = data.clientId
  self.roleKey = data.roleKey
  self.equipKey = data.equipKey
  return true
end

CDeleteDungeonEquipRedDotOneLine.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
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

