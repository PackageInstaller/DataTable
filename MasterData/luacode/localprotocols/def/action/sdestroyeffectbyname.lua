local SDestroyEffectByName = dataclass("SDestroyEffectByName")
SDestroyEffectByName.ProtocolType = 43
SDestroyEffectByName.camp = 0
SDestroyEffectByName.effectname = ""

function SDestroyEffectByName:Ctor(client)
end

function SDestroyEffectByName:Marshal(data)
  data.camp = self.camp
  data.effectname = self.effectname
end

function SDestroyEffectByName:Unmarshal(data)
  self.camp = data.camp
  self.effectname = data.effectname
  return true
end

function SDestroyEffectByName:CheckVariable()
  if type(self.camp) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.camp) = %s. number required.", type(self.camp))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  return true
end

return SDestroyEffectByName
