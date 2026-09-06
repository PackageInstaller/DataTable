local SActiveSkillStateChange = dataclass("SActiveSkillStateChange")
SActiveSkillStateChange.ProtocolType = 51
SActiveSkillStateChange.entityid = 0
SActiveSkillStateChange.skillid = 0
SActiveSkillStateChange.isInCD = 0

function SActiveSkillStateChange:Ctor(client)
end

function SActiveSkillStateChange:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.isInCD = self.isInCD
end

function SActiveSkillStateChange:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.isInCD = data.isInCD
  return true
end

function SActiveSkillStateChange:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.isInCD) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isInCD) = %s. number required.", type(self.isInCD))
    return false
  end
  return true
end

return SActiveSkillStateChange
