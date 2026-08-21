-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbreakoutpowernumber.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBreakOutPowerNumber = dataclass("SBreakOutPowerNumber")
SBreakOutPowerNumber.ProtocolType = 61
SBreakOutPowerNumber.breakoutPower = 0
SBreakOutPowerNumber.breakoutPowerMax = 0
SBreakOutPowerNumber.Ctor = function(self, client)
  -- function num : 0_0
end

SBreakOutPowerNumber.Marshal = function(self, data)
  -- function num : 0_1
  data.breakoutPower = self.breakoutPower
  data.breakoutPowerMax = self.breakoutPowerMax
end

SBreakOutPowerNumber.Unmarshal = function(self, data)
  -- function num : 0_2
  self.breakoutPower = data.breakoutPower
  self.breakoutPowerMax = data.breakoutPowerMax
  return true
end

SBreakOutPowerNumber.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.breakoutPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.breakoutPower) = %s. number required.", type(self.breakoutPower))
    return false
  end
  if type(self.breakoutPowerMax) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.breakoutPowerMax) = %s. number required.", type(self.breakoutPowerMax))
    return false
  end
  return true
end

return SBreakOutPowerNumber

