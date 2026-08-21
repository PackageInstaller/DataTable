-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/supdateroleskillpowerreduce.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateRoleSkillPowerReduce = dataclass("SUpdateRoleSkillPowerReduce")
SUpdateRoleSkillPowerReduce.ProtocolType = 42
SUpdateRoleSkillPowerReduce.entityid = 0
SUpdateRoleSkillPowerReduce.order = 0
SUpdateRoleSkillPowerReduce.chaos = 0
SUpdateRoleSkillPowerReduce.Ctor = function(self, client)
  -- function num : 0_0
end

SUpdateRoleSkillPowerReduce.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.order = self.order
  data.chaos = self.chaos
end

SUpdateRoleSkillPowerReduce.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.order = data.order
  self.chaos = data.chaos
  return true
end

SUpdateRoleSkillPowerReduce.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.order) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.order) = %s. number required.", type(self.order))
    return false
  end
  if type(self.chaos) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.chaos) = %s. number required.", type(self.chaos))
    return false
  end
  return true
end

return SUpdateRoleSkillPowerReduce

