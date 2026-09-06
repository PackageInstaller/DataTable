local SShieldValueChange = dataclass("SShieldValueChange")
SShieldValueChange.ProtocolType = 47
SShieldValueChange.entityid = 0
SShieldValueChange.buffid = 0
SShieldValueChange.shieldtype = 0
SShieldValueChange.value = 0

function SShieldValueChange:Ctor(client)
end

function SShieldValueChange:Marshal(data)
  data.entityid = self.entityid
  data.buffid = self.buffid
  data.shieldtype = self.shieldtype
  data.value = self.value
end

function SShieldValueChange:Unmarshal(data)
  self.entityid = data.entityid
  self.buffid = data.buffid
  self.shieldtype = data.shieldtype
  self.value = data.value
  return true
end

function SShieldValueChange:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.buffid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.buffid) = %s. number required.", type(self.buffid))
    return false
  end
  if type(self.shieldtype) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.shieldtype) = %s. number required.", type(self.shieldtype))
    return false
  end
  if type(self.value) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.value) = %s. number required.", type(self.value))
    return false
  end
  return true
end

return SShieldValueChange
