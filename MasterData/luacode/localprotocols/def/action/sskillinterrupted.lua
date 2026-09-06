local SSkillInterrupted = dataclass("SSkillInterrupted")
SSkillInterrupted.ProtocolType = 45
SSkillInterrupted.entityid = 0
SSkillInterrupted.skillid = 0

function SSkillInterrupted:Ctor(client)
end

function SSkillInterrupted:Marshal(data)
  data.entityid = self.entityid
  data.skillid = self.skillid
end

function SSkillInterrupted:Unmarshal(data)
  self.entityid = data.entityid
  self.skillid = data.skillid
  return true
end

function SSkillInterrupted:CheckVariable()
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

return SSkillInterrupted
