-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/dungeonreddot/cdeletedungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDeleteDungeonEquipRedDot = dataclass("CDeleteDungeonEquipRedDot")
CDeleteDungeonEquipRedDot.ProtocolType = 204
CDeleteDungeonEquipRedDot.clientId = 0
CDeleteDungeonEquipRedDot.Ctor = function(self, client)
  -- function num : 0_0
end

CDeleteDungeonEquipRedDot.Marshal = function(self, data)
  -- function num : 0_1
  data.clientId = self.clientId
end

CDeleteDungeonEquipRedDot.Unmarshal = function(self, data)
  -- function num : 0_2
  self.clientId = data.clientId
  return true
end

CDeleteDungeonEquipRedDot.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CDeleteDungeonEquipRedDot

