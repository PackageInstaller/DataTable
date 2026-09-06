local CPartner = dataclass("CPartner")
CPartner.ProtocolType = 32

function CPartner:Ctor(client)
end

function CPartner:Marshal(data)
end

function CPartner:Unmarshal(data)
  return true
end

function CPartner:CheckVariable()
  return true
end

return CPartner
