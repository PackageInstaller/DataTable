-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/saccumulatepowerstatechange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SAccumulatePowerStateChange = dataclass("SAccumulatePowerStateChange")
SAccumulatePowerStateChange.ProtocolType = 49
SAccumulatePowerStateChange.state = 0
SAccumulatePowerStateChange.Ctor = function(self, client)
  -- function num : 0_0
end

SAccumulatePowerStateChange.Marshal = function(self, data)
  -- function num : 0_1
  data.state = self.state
end

SAccumulatePowerStateChange.Unmarshal = function(self, data)
  -- function num : 0_2
  self.state = data.state
  return true
end

SAccumulatePowerStateChange.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.state) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.state) = %s. number required.", type(self.state))
    return false
  end
  return true
end

return SAccumulatePowerStateChange

