local SPartner = dataclass("SPartner")
SPartner.ProtocolType = 33
SPartner.count = 0

function SPartner:Ctor(client)
end

function SPartner:Marshal(data)
  data.count = self.count
end

function SPartner:Unmarshal(data)
  self.count = data.count
  return true
end

function SPartner:CheckVariable()
  if type(self.count) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.count) = %s. number required.", type(self.count))
    return false
  end
  return true
end

return SPartner
