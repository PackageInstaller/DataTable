-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/dungeonreddot/cstoredungeonequipreddot.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStoreDungeonEquipRedDot = dataclass("CStoreDungeonEquipRedDot")
CStoreDungeonEquipRedDot.ProtocolType = 201
CStoreDungeonEquipRedDot.clientId = 0
CStoreDungeonEquipRedDot.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : _ENV
  self.redDotData = ((require("localprotocols.bean.data.equipreddotdata")).Create)()
end

CStoreDungeonEquipRedDot.Marshal = function(self, data)
  -- function num : 0_1
  data.clientId = self.clientId
  data.redDotData = {}
  ;
  (self.redDotData):Marshal(data.redDotData)
end

CStoreDungeonEquipRedDot.Unmarshal = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self.clientId = data.clientId
  self.redDotData = ((require("localprotocols.bean.data.equipreddotdata")).Create)()
  ;
  (self.redDotData):Unmarshal(data.redDotData)
  return true
end

CStoreDungeonEquipRedDot.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.clientId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.clientId) = %s. number required.", type(self.clientId))
    return false
  end
  if not (self.redDotData):CheckVariable() then
    return false
  end
  return true
end

return CStoreDungeonEquipRedDot

