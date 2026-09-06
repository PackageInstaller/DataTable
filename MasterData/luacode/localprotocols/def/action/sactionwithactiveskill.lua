local SActionWithActiveSkill = dataclass("SActionWithActiveSkill")
SActionWithActiveSkill.ProtocolType = 60
SActionWithActiveSkill.entityId = 0
SActionWithActiveSkill.skillId = 0
SActionWithActiveSkill.enermyEntityId = 0

function SActionWithActiveSkill:Ctor(client)
end

function SActionWithActiveSkill:Marshal(data)
  data.entityId = self.entityId
  data.skillId = self.skillId
  data.enermyEntityId = self.enermyEntityId
end

function SActionWithActiveSkill:Unmarshal(data)
  self.entityId = data.entityId
  self.skillId = data.skillId
  self.enermyEntityId = data.enermyEntityId
  return true
end

function SActionWithActiveSkill:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skillId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillId) = %s. number required.", type(self.skillId))
    return false
  end
  if type(self.enermyEntityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.enermyEntityId) = %s. number required.", type(self.enermyEntityId))
    return false
  end
  return true
end

return SActionWithActiveSkill
