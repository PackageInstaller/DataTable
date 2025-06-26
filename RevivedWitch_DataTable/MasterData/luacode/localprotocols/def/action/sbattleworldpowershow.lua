-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbattleworldpowershow.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattleWorldPowerShow = dataclass("SBattleWorldPowerShow")
SBattleWorldPowerShow.ProtocolType = 11
SBattleWorldPowerShow.redMaxPower = 0
SBattleWorldPowerShow.redCurrentPower = 0
SBattleWorldPowerShow.blueMaxPower = 0
SBattleWorldPowerShow.blueCurrentPower = 0
SBattleWorldPowerShow.Ctor = function(self, client)
  -- function num : 0_0
end

SBattleWorldPowerShow.Marshal = function(self, data)
  -- function num : 0_1
  data.redMaxPower = self.redMaxPower
  data.redCurrentPower = self.redCurrentPower
  data.blueMaxPower = self.blueMaxPower
  data.blueCurrentPower = self.blueCurrentPower
end

SBattleWorldPowerShow.Unmarshal = function(self, data)
  -- function num : 0_2
  self.redMaxPower = data.redMaxPower
  self.redCurrentPower = data.redCurrentPower
  self.blueMaxPower = data.blueMaxPower
  self.blueCurrentPower = data.blueCurrentPower
  return true
end

SBattleWorldPowerShow.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.redMaxPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redMaxPower) = %s. number required.", type(self.redMaxPower))
    return false
  end
  if type(self.redCurrentPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.redCurrentPower) = %s. number required.", type(self.redCurrentPower))
    return false
  end
  if type(self.blueMaxPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.blueMaxPower) = %s. number required.", type(self.blueMaxPower))
    return false
  end
  if type(self.blueCurrentPower) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.blueCurrentPower) = %s. number required.", type(self.blueCurrentPower))
    return false
  end
  return true
end

return SBattleWorldPowerShow

