-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/supdaterolebuffs.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SUpdateRoleBuffs = dataclass("SUpdateRoleBuffs")
SUpdateRoleBuffs.ProtocolType = 40
SUpdateRoleBuffs.entityid = 0
SUpdateRoleBuffs.buffid = 0
SUpdateRoleBuffs.counttime = 0
SUpdateRoleBuffs.stacklayer = 0
SUpdateRoleBuffs.Ctor = function(self, client)
  -- function num : 0_0
end

SUpdateRoleBuffs.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.buffid = self.buffid
  data.counttime = self.counttime
  data.stacklayer = self.stacklayer
end

SUpdateRoleBuffs.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.buffid = data.buffid
  self.counttime = data.counttime
  self.stacklayer = data.stacklayer
  return true
end

SUpdateRoleBuffs.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.buffid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.buffid) = %s. number required.", type(self.buffid))
    return false
  end
  if type(self.counttime) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.counttime) = %s. number required.", type(self.counttime))
    return false
  end
  if type(self.stacklayer) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.stacklayer) = %s. number required.", type(self.stacklayer))
    return false
  end
  return true
end

return SUpdateRoleBuffs

