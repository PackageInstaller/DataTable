local SUpdateRoleBuffs = dataclass("SUpdateRoleBuffs")
SUpdateRoleBuffs.ProtocolType = 40
SUpdateRoleBuffs.entityid = 0
SUpdateRoleBuffs.buffid = 0
SUpdateRoleBuffs.counttime = 0
SUpdateRoleBuffs.stacklayer = 0

function SUpdateRoleBuffs:Ctor(client)
end

function SUpdateRoleBuffs:Marshal(data)
  data.entityid = self.entityid
  data.buffid = self.buffid
  data.counttime = self.counttime
  data.stacklayer = self.stacklayer
end

function SUpdateRoleBuffs:Unmarshal(data)
  self.entityid = data.entityid
  self.buffid = data.buffid
  self.counttime = data.counttime
  self.stacklayer = data.stacklayer
  return true
end

function SUpdateRoleBuffs:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.buffid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.buffid) = %s. number required.", type(self.buffid))
    return false
  end
  if type(self.counttime) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.counttime) = %s. number required.", type(self.counttime))
    return false
  end
  if type(self.stacklayer) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.stacklayer) = %s. number required.", type(self.stacklayer))
    return false
  end
  return true
end

return SUpdateRoleBuffs
