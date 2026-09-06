local SRoleIsCanUseSKill = dataclass("SRoleIsCanUseSKill")
SRoleIsCanUseSKill.ProtocolType = 36
SRoleIsCanUseSKill.entityid = 0
SRoleIsCanUseSKill.iscan = 0

function SRoleIsCanUseSKill:Ctor(client)
end

function SRoleIsCanUseSKill:Marshal(data)
  data.entityid = self.entityid
  data.iscan = self.iscan
end

function SRoleIsCanUseSKill:Unmarshal(data)
  self.entityid = data.entityid
  self.iscan = data.iscan
  return true
end

function SRoleIsCanUseSKill:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.iscan) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.iscan) = %s. number required.", type(self.iscan))
    return false
  end
  return true
end

return SRoleIsCanUseSKill
