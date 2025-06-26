-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/suseskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUseSkill = dataclass("SUseSkill")
SUseSkill.ProtocolType = 14
SUseSkill.entityid = 0
SUseSkill.skillid = 0
SUseSkill.camp = 0
SUseSkill.isImaged = 0
SUseSkill.Ctor = function(self, client)
  -- function num : 0_0
end

SUseSkill.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.camp = self.camp
  data.isImaged = self.isImaged
end

SUseSkill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.camp = data.camp
  self.isImaged = data.isImaged
  return true
end

SUseSkill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.isImaged) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isImaged) = %s. number required.", type(self.isImaged))
    return false
  end
  return true
end

return SUseSkill

