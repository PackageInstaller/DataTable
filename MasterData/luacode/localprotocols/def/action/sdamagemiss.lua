local SDamageMiss = dataclass("SDamageMiss")
SDamageMiss.ProtocolType = 34
SDamageMiss.entityid = 0
SDamageMiss.damegetype = 0

function SDamageMiss:Ctor(client)
end

function SDamageMiss:Marshal(data)
  data.entityid = self.entityid
  data.damegetype = self.damegetype
end

function SDamageMiss:Unmarshal(data)
  self.entityid = data.entityid
  self.damegetype = data.damegetype
  return true
end

function SDamageMiss:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.damegetype) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.damegetype) = %s. number required.", type(self.damegetype))
    return false
  end
  return true
end

return SDamageMiss
