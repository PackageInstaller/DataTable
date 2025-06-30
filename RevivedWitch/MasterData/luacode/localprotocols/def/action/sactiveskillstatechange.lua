-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sactiveskillstatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SActiveSkillStateChange = dataclass("SActiveSkillStateChange")
SActiveSkillStateChange.ProtocolType = 51
SActiveSkillStateChange.entityid = 0
SActiveSkillStateChange.skillid = 0
SActiveSkillStateChange.isInCD = 0
SActiveSkillStateChange.Ctor = function(self, client)
  -- function num : 0_0
end

SActiveSkillStateChange.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.isInCD = self.isInCD
end

SActiveSkillStateChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.isInCD = data.isInCD
  return true
end

SActiveSkillStateChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.isInCD) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isInCD) = %s. number required.", type(self.isInCD))
    return false
  end
  return true
end

return SActiveSkillStateChange

