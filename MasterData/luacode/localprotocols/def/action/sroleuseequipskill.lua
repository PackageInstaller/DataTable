local SRoleUseEquipSkill = dataclass("SRoleUseEquipSkill")
SRoleUseEquipSkill.ProtocolType = 39
SRoleUseEquipSkill.entityid = 0
SRoleUseEquipSkill.skillid = 0

function SRoleUseEquipSkill:Ctor(client)
end

function SRoleUseEquipSkill:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
end

function SRoleUseEquipSkill:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  return true
end

function SRoleUseEquipSkill:CheckVariable()
  if type(self.entityid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.entityid) = %s. number required.", type(self.entityid))
    return false
  end
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SRoleUseEquipSkill
