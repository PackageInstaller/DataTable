local SBattleWorldPowerShow = dataclass("SBattleWorldPowerShow")
SBattleWorldPowerShow.ProtocolType = 11
SBattleWorldPowerShow.redMaxPower = 0
SBattleWorldPowerShow.redCurrentPower = 0
SBattleWorldPowerShow.blueMaxPower = 0
SBattleWorldPowerShow.blueCurrentPower = 0

function SBattleWorldPowerShow:Ctor(client)
end

function SBattleWorldPowerShow:Marshal(data)
  data.redMaxPower = self.redMaxPower
  data.redCurrentPower = self.redCurrentPower
  data.blueMaxPower = self.blueMaxPower
  data.blueCurrentPower = self.blueCurrentPower
end

function SBattleWorldPowerShow:Unmarshal(data)
  self.redMaxPower = data.redMaxPower
  self.redCurrentPower = data.redCurrentPower
  self.blueMaxPower = data.blueMaxPower
  self.blueCurrentPower = data.blueCurrentPower
  return true
end

function SBattleWorldPowerShow:CheckVariable()
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
