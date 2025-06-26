-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sroledead.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SRoleDead = dataclass("SRoleDead")
SRoleDead.ProtocolType = 2
SRoleDead.entityId = 0
SRoleDead.damageFrom = 0
SRoleDead.damageNum = 0
SRoleDead.isrunaway = 0
SRoleDead.Ctor = function(self, client)
  -- function num : 0_0
end

SRoleDead.Marshal = function(self, data)
  -- function num : 0_1
  data.entityId = self.entityId
  data.damageFrom = self.damageFrom
  data.damageNum = self.damageNum
  data.isrunaway = self.isrunaway
end

SRoleDead.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityId = data.entityId
  self.damageFrom = data.damageFrom
  self.damageNum = data.damageNum
  self.isrunaway = data.isrunaway
  return true
end

SRoleDead.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.damageFrom) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damageFrom) = %s. number required.", type(self.damageFrom))
    return false
  end
  if type(self.damageNum) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damageNum) = %s. number required.", type(self.damageNum))
    return false
  end
  if type(self.isrunaway) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isrunaway) = %s. number required.", type(self.isrunaway))
    return false
  end
  return true
end

return SRoleDead

