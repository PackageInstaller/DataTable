-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/cskillact.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillAct = dataclass("CSkillAct")
CSkillAct.ProtocolType = 5
CSkillAct.entityId = 0
CSkillAct.skillid = 0
CSkillAct.Ctor = function(self, client)
  -- function num : 0_0
end

CSkillAct.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.skillid = self.skillid
end

CSkillAct.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.skillid = data.skillid
  return true
end

CSkillAct.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return CSkillAct

