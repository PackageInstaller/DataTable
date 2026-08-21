-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbattlerplayanimationbyname.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattlerPlayAnimationByName = dataclass("SBattlerPlayAnimationByName")
SBattlerPlayAnimationByName.ProtocolType = 18
SBattlerPlayAnimationByName.entityid = 0
SBattlerPlayAnimationByName.name = ""
SBattlerPlayAnimationByName.ignorePriority = 0
SBattlerPlayAnimationByName.Ctor = function(self, client)
  -- function num : 0_0
end

SBattlerPlayAnimationByName.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.name = self.name
  data.ignorePriority = self.ignorePriority
end

SBattlerPlayAnimationByName.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.name = data.name
  self.ignorePriority = data.ignorePriority
  return true
end

SBattlerPlayAnimationByName.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.name) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.name) = %s. string required.", type(self.name))
    return false
  end
  if type(self.ignorePriority) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.ignorePriority) = %s. number required.", type(self.ignorePriority))
    return false
  end
  return true
end

return SBattlerPlayAnimationByName

