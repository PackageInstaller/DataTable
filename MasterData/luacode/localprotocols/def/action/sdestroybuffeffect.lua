local SDestroyBuffEffect = dataclass("SDestroyBuffEffect")
SDestroyBuffEffect.ProtocolType = 22
SDestroyBuffEffect.entityid = 0
SDestroyBuffEffect.point = ""
SDestroyBuffEffect.effectname = ""

function SDestroyBuffEffect:Ctor(client)
end

function SDestroyBuffEffect:Marshal(data)
  data.entityid = self.entityid
  data.point = self.point
  data.effectname = self.effectname
end

function SDestroyBuffEffect:Unmarshal(data)
  self.entityid = data.entityid
  self.point = data.point
  self.effectname = data.effectname
  return true
end

function SDestroyBuffEffect:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.point) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.point) = %s. string required.", type(self.point))
    return false
  end
  if type(self.effectname) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.effectname) = %s. string required.", type(self.effectname))
    return false
  end
  return true
end

return SDestroyBuffEffect
