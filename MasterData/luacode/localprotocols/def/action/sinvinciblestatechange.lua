local SInvincibleStateChange = dataclass("SInvincibleStateChange")
SInvincibleStateChange.ProtocolType = 46
SInvincibleStateChange.entityid = 0
SInvincibleStateChange.state = 0

function SInvincibleStateChange:Ctor(client)
end

function SInvincibleStateChange:Marshal(data)
  data.entityid = self.entityid
  data.state = self.state
end

function SInvincibleStateChange:Unmarshal(data)
  self.entityid = data.entityid
  self.state = data.state
  return true
end

function SInvincibleStateChange:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.state) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.state) = %s. number required.", type(self.state))
    return false
  end
  return true
end

return SInvincibleStateChange
