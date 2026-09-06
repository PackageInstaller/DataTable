local SBattlerPlayAnimationByName = dataclass("SBattlerPlayAnimationByName")
SBattlerPlayAnimationByName.ProtocolType = 18
SBattlerPlayAnimationByName.entityid = 0
SBattlerPlayAnimationByName.name = ""
SBattlerPlayAnimationByName.ignorePriority = 0

function SBattlerPlayAnimationByName:Ctor(client)
end

function SBattlerPlayAnimationByName:Marshal(data)
  data.entityid = self.entityid
  data.name = self.name
  data.ignorePriority = self.ignorePriority
end

function SBattlerPlayAnimationByName:Unmarshal(data)
  self.entityid = data.entityid
  self.name = data.name
  self.ignorePriority = data.ignorePriority
  return true
end

function SBattlerPlayAnimationByName:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.name) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.name) = %s. string required.", type(self.name))
    return false
  end
  if type(self.ignorePriority) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.ignorePriority) = %s. number required.", type(self.ignorePriority))
    return false
  end
  return true
end

return SBattlerPlayAnimationByName
