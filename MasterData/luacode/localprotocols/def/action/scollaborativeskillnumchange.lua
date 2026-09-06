local SCollaborativeSkillNumChange = dataclass("SCollaborativeSkillNumChange")
SCollaborativeSkillNumChange.ProtocolType = 59
SCollaborativeSkillNumChange.entityid = 0
SCollaborativeSkillNumChange.num = 0

function SCollaborativeSkillNumChange:Ctor(client)
end

function SCollaborativeSkillNumChange:Marshal(data)
  data.entityid = self.entityid
  data.num = self.num
end

function SCollaborativeSkillNumChange:Unmarshal(data)
  self.entityid = data.entityid
  self.num = data.num
  return true
end

function SCollaborativeSkillNumChange:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.num) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.num) = %s. number required.", type(self.num))
    return false
  end
  return true
end

return SCollaborativeSkillNumChange
