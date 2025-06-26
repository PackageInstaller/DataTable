-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sskillfail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillFail = dataclass("SSkillFail")
SSkillFail.ProtocolType = 13
SSkillFail.entityid = 0
SSkillFail.skillid = 0
SSkillFail.type = 0
SSkillFail.Power = 1
SSkillFail.CanNotInterrupt = 2
SSkillFail.InCD = 3
SSkillFail.DBuff = 4
SSkillFail.TargetPoint = 5
SSkillFail.Ctor = function(self, client)
  -- function num : 0_0
end

SSkillFail.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.type = self.type
end

SSkillFail.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.type = data.type
  return true
end

SSkillFail.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  return true
end

return SSkillFail

