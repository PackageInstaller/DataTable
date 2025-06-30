-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sactionwithactiveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SActionWithActiveSkill = dataclass("SActionWithActiveSkill")
SActionWithActiveSkill.ProtocolType = 60
SActionWithActiveSkill.entityId = 0
SActionWithActiveSkill.skillId = 0
SActionWithActiveSkill.enermyEntityId = 0
SActionWithActiveSkill.Ctor = function(self, client)
  -- function num : 0_0
end

SActionWithActiveSkill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.skillId = self.skillId
  data.enermyEntityId = self.enermyEntityId
end

SActionWithActiveSkill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.skillId = data.skillId
  self.enermyEntityId = data.enermyEntityId
  return true
end

SActionWithActiveSkill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skillId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillId) = %s. number required.", type(self.skillId))
    return false
  end
  if type(self.enermyEntityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.enermyEntityId) = %s. number required.", type(self.enermyEntityId))
    return false
  end
  return true
end

return SActionWithActiveSkill

