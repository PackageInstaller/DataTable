local SAccumulatePowerStateChange = dataclass("SAccumulatePowerStateChange")
SAccumulatePowerStateChange.ProtocolType = 49
SAccumulatePowerStateChange.state = 0

function SAccumulatePowerStateChange:Ctor(client)
end

function SAccumulatePowerStateChange:Marshal(data)
  data.state = self.state
end

function SAccumulatePowerStateChange:Unmarshal(data)
  self.state = data.state
  return true
end

function SAccumulatePowerStateChange:CheckVariable()
  if type(self.state) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.state) = %s. number required.", type(self.state))
    return false
  end
  return true
end

return SAccumulatePowerStateChange
