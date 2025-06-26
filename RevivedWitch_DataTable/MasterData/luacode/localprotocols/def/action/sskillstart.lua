-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sskillstart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SSkillStart = dataclass("SSkillStart")
SSkillStart.ProtocolType = 19
SSkillStart.skillid = 0
SSkillStart.Ctor = function(self, client)
  -- function num : 0_0
end

SSkillStart.Marshal = function(self, data)
  -- function num : 0_1
  data.skillid = self.skillid
end

SSkillStart.Unmarshal = function(self, data)
  -- function num : 0_2
  self.skillid = data.skillid
  return true
end

SSkillStart.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SSkillStart

