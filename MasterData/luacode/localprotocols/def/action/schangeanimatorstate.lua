local SChangeAnimatorState = dataclass("SChangeAnimatorState")
SChangeAnimatorState.ProtocolType = 55
SChangeAnimatorState.animatorType = 0
SChangeAnimatorState.param = ""
SChangeAnimatorState.value = 0

function SChangeAnimatorState:Ctor(client)
end

function SChangeAnimatorState:Marshal(data)
  data.animatorType = self.animatorType
  data.param = self.param
  data.value = self.value
end

function SChangeAnimatorState:Unmarshal(data)
  self.animatorType = data.animatorType
  self.param = data.param
  self.value = data.value
  return true
end

function SChangeAnimatorState:CheckVariable()
  if type(self.animatorType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.animatorType) = %s. number required.", type(self.animatorType))
    return false
  end
  if type(self.param) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.param) = %s. string required.", type(self.param))
    return false
  end
  if type(self.value) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.value) = %s. number required.", type(self.value))
    return false
  end
  return true
end

return SChangeAnimatorState
