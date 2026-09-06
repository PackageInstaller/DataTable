local SUpdateRoleSkillPowerReduce = dataclass("SUpdateRoleSkillPowerReduce")
SUpdateRoleSkillPowerReduce.ProtocolType = 42
SUpdateRoleSkillPowerReduce.entityid = 0
SUpdateRoleSkillPowerReduce.order = 0
SUpdateRoleSkillPowerReduce.chaos = 0

function SUpdateRoleSkillPowerReduce:Ctor(client)
end

function SUpdateRoleSkillPowerReduce:Marshal(data)
  data.entityid = self.entityid
  data.order = self.order
  data.chaos = self.chaos
end

function SUpdateRoleSkillPowerReduce:Unmarshal(data)
  self.entityid = data.entityid
  self.order = data.order
  self.chaos = data.chaos
  return true
end

function SUpdateRoleSkillPowerReduce:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.order) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.order) = %s. number required.", type(self.order))
    return false
  end
  if type(self.chaos) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.chaos) = %s. number required.", type(self.chaos))
    return false
  end
  return true
end

return SUpdateRoleSkillPowerReduce
