-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sinvinciblestatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SInvincibleStateChange = dataclass("SInvincibleStateChange")
SInvincibleStateChange.ProtocolType = 46
SInvincibleStateChange.entityid = 0
SInvincibleStateChange.state = 0
SInvincibleStateChange.Ctor = function(self, client)
  -- function num : 0_0
end

SInvincibleStateChange.Marshal = function(self, data)
  -- function num : 0_1
  data.entityid = self.entityid
  data.state = self.state
end

SInvincibleStateChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.entityid = data.entityid
  self.state = data.state
  return true
end

SInvincibleStateChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.state) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.state) = %s. number required.", type(self.state))
    return false
  end
  return true
end

return SInvincibleStateChange

