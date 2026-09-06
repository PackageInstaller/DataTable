local SShowOrderPowerSpecialUIEffect = dataclass("SShowOrderPowerSpecialUIEffect")
SShowOrderPowerSpecialUIEffect.ProtocolType = 58
SShowOrderPowerSpecialUIEffect.effectType = 0
SShowOrderPowerSpecialUIEffect.powerGridIndex = 0

function SShowOrderPowerSpecialUIEffect:Ctor(client)
end

function SShowOrderPowerSpecialUIEffect:Marshal(data)
  data.effectType = self.effectType
  data.powerGridIndex = self.powerGridIndex
end

function SShowOrderPowerSpecialUIEffect:Unmarshal(data)
  self.effectType = data.effectType
  self.powerGridIndex = data.powerGridIndex
  return true
end

function SShowOrderPowerSpecialUIEffect:CheckVariable()
  if type(self.effectType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectType) = %s. number required.", type(self.effectType))
    return false
  end
  if type(self.powerGridIndex) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.powerGridIndex) = %s. number required.", type(self.powerGridIndex))
    return false
  end
  return true
end

return SShowOrderPowerSpecialUIEffect
