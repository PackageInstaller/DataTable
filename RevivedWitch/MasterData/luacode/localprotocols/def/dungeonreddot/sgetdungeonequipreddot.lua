-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/dungeonreddot/sgetdungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SGetDungeonEquipRedDot = dataclass("SGetDungeonEquipRedDot")
SGetDungeonEquipRedDot.ProtocolType = 203
SGetDungeonEquipRedDot.clientId = 0
SGetDungeonEquipRedDot.Ctor = function(self, client)
  -- function num : 0_0
  self.redDotData = {}
end

SGetDungeonEquipRedDot.Marshal = function(self, data)
  -- function num : 0_1 , upvalues : _ENV
  data.clientId = self.clientId
  data.redDotData = {}
  for index,value in ipairs(self.redDotData) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    (data.redDotData)[index] = {}
    ;
    ((self.redDotData)[index]):Marshal((data.redDotData)[index])
  end
end

SGetDungeonEquipRedDot.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.clientId = data.clientId
  for index,value in ipairs(data.redDotData) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

    (self.redDotData)[index] = ((require("localprotocols.bean.data.equipreddotdata")).Create)()
    ;
    ((self.redDotData)[index]):Unmarshal((data.redDotData)[index])
  end
  return true
end

SGetDungeonEquipRedDot.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if type(self.redDotData) ~= "table" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redDotData) = %s. table required.", type(self.redDotData))
    return false
  end
  for index,value in ipairs(self.redDotData) do
    if not value:CheckVariable() then
      return false
    end
  end
  return true
end

return SGetDungeonEquipRedDot

