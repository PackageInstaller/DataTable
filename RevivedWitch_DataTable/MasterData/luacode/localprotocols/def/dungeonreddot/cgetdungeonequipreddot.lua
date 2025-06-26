-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/dungeonreddot/cgetdungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CGetDungeonEquipRedDot = dataclass("CGetDungeonEquipRedDot")
CGetDungeonEquipRedDot.ProtocolType = 202
CGetDungeonEquipRedDot.clientId = 0
CGetDungeonEquipRedDot.Ctor = function(self, client)
  -- function num : 0_0
end

CGetDungeonEquipRedDot.Marshal = function(self, data)
  -- function num : 0_1
  data.clientId = self.clientId
end

CGetDungeonEquipRedDot.Unmarshal = function(self, data)
  -- function num : 0_2
  self.clientId = data.clientId
  return true
end

CGetDungeonEquipRedDot.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  return true
end

return CGetDungeonEquipRedDot

