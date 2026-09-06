local SBreakOutPowerNumber = dataclass("SBreakOutPowerNumber")
SBreakOutPowerNumber.ProtocolType = 61
SBreakOutPowerNumber.breakoutPower = 0
SBreakOutPowerNumber.breakoutPowerMax = 0

function SBreakOutPowerNumber:Ctor(client)
end

function SBreakOutPowerNumber:Marshal(data)
  data.breakoutPower = self.breakoutPower
  data.breakoutPowerMax = self.breakoutPowerMax
end

function SBreakOutPowerNumber:Unmarshal(data)
  self.breakoutPower = data.breakoutPower
  self.breakoutPowerMax = data.breakoutPowerMax
  return true
end

function SBreakOutPowerNumber:CheckVariable()
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
