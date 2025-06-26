-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sshieldvaluechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SShieldValueChange = dataclass("SShieldValueChange")
SShieldValueChange.ProtocolType = 47
SShieldValueChange.entityid = 0
SShieldValueChange.buffid = 0
SShieldValueChange.shieldtype = 0
SShieldValueChange.value = 0
SShieldValueChange.Ctor = function(self, client)
  -- function num : 0_0
end

SShieldValueChange.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.buffid = self.buffid
  data.shieldtype = self.shieldtype
  data.value = self.value
end

SShieldValueChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.buffid = data.buffid
  self.shieldtype = data.shieldtype
  self.value = data.value
  return true
end

SShieldValueChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.buffid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.buffid) = %s. number required.", type(self.buffid))
    return false
  end
  if type(self.shieldtype) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.shieldtype) = %s. number required.", type(self.shieldtype))
    return false
  end
  if type(self.value) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.value) = %s. number required.", type(self.value))
    return false
  end
  return true
end

return SShieldValueChange

