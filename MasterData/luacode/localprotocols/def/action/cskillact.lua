local CSkillAct = dataclass("CSkillAct")
CSkillAct.ProtocolType = 5
CSkillAct.entityId = 0
CSkillAct.skillid = 0

function CSkillAct:Ctor(client)
end

function CSkillAct:Marshal(data)
  data.entityId = self.entityId
  data.skillid = self.skillid
end

function CSkillAct:Unmarshal(data)
  self.entityId = data.entityId
  self.skillid = data.skillid
  return true
end

function CSkillAct:CheckVariable()
  if type(self.entityId) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityId) = %s. number required.", type(self.entityId))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return CSkillAct
