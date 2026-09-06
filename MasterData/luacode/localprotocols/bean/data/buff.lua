local Buff = dataclass("Buff")
Buff.id = 0
Buff.key = 0
Buff.countdown = 0

function Buff:Ctor()
end

function Buff:Marshal(data)
  data.id = self.id
  data.key = self.key
  data.countdown = self.countdown
end

function Buff:Unmarshal(data)
  self.id = data.id
  self.key = data.key
  self.countdown = data.countdown
end

function Buff:CheckVariable()
  if type(self.id) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.id) = %s. number required.", type(self.id))
    return false
  end
  if type(self.key) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.key) = %s. number required.", type(self.key))
    return false
  end
  if type(self.countdown) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.countdown) = %s. number required.", type(self.countdown))
    return false
  end
  return true
end

return Buff
