-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/scollaborativeskillnumchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SCollaborativeSkillNumChange = dataclass("SCollaborativeSkillNumChange")
SCollaborativeSkillNumChange.ProtocolType = 59
SCollaborativeSkillNumChange.entityid = 0
SCollaborativeSkillNumChange.num = 0
SCollaborativeSkillNumChange.Ctor = function(self, client)
  -- function num : 0_0
end

SCollaborativeSkillNumChange.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.num = self.num
end

SCollaborativeSkillNumChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.num = data.num
  return true
end

SCollaborativeSkillNumChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.num) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.num) = %s. number required.", type(self.num))
    return false
  end
  return true
end

return SCollaborativeSkillNumChange

