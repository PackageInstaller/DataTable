local SSkillFail = dataclass("SSkillFail")
SSkillFail.ProtocolType = 13
SSkillFail.entityid = 0
SSkillFail.skillid = 0
SSkillFail.type = 0
SSkillFail.Power = 1
SSkillFail.CanNotInterrupt = 2
SSkillFail.InCD = 3
SSkillFail.DBuff = 4
SSkillFail.TargetPoint = 5

function SSkillFail:Ctor(client)
end

function SSkillFail:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
  data.type = self.type
end

function SSkillFail:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  self.type = data.type
  return true
end

function SSkillFail:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  return true
end

return SSkillFail
