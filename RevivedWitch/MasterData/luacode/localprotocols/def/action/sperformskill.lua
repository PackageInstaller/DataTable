-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sperformskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPerformSkill = dataclass("SPerformSkill")
SPerformSkill.ProtocolType = 4
SPerformSkill.entityId = 0
SPerformSkill.skilleffectid = 0
SPerformSkill.rad = 0
SPerformSkill.Ctor = function(self, client)
  -- function num : 0_0
end

SPerformSkill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.skilleffectid = self.skilleffectid
  data.rad = self.rad
end

SPerformSkill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.skilleffectid = data.skilleffectid
  self.rad = data.rad
  return true
end

SPerformSkill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skilleffectid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skilleffectid) = %s. number required.", type(self.skilleffectid))
    return false
  end
  if type(self.rad) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.rad) = %s. number required.", type(self.rad))
    return false
  end
  return true
end

return SPerformSkill

