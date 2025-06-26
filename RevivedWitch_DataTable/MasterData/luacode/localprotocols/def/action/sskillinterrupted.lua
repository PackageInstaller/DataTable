-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sskillinterrupted.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillInterrupted = dataclass("SSkillInterrupted")
SSkillInterrupted.ProtocolType = 45
SSkillInterrupted.entityid = 0
SSkillInterrupted.skillid = 0
SSkillInterrupted.Ctor = function(self, client)
  -- function num : 0_0
end

SSkillInterrupted.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
end

SSkillInterrupted.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  return true
end

SSkillInterrupted.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SSkillInterrupted

