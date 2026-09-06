local SDestroyObject = dataclass("SDestroyObject")
SDestroyObject.ProtocolType = 7
SDestroyObject.entityid = 0
SDestroyObject.skillid = 0
SDestroyObject.isimageentity = 0
SDestroyObject.ispartner = 0

function SDestroyObject:Ctor(client)
end

function SDestroyObject:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.isimageentity = self.isimageentity
  data.ispartner = self.ispartner
end

function SDestroyObject:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.isimageentity = data.isimageentity
  self.ispartner = data.ispartner
  return true
end

function SDestroyObject:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.isimageentity) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isimageentity) = %s. number required.", type(self.isimageentity))
    return false
  end
  if type(self.ispartner) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.ispartner) = %s. number required.", type(self.ispartner))
    return false
  end
  return true
end

return SDestroyObject
