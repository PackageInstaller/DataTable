local SSkillStart = dataclass("SSkillStart")
SSkillStart.ProtocolType = 19
SSkillStart.skillid = 0

function SSkillStart:Ctor(client)
end

function SSkillStart:Marshal(data)
  data.skillid = self.skillid
end

function SSkillStart:Unmarshal(data)
  self.skillid = data.skillid
  return true
end

function SSkillStart:CheckVariable()
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SSkillStart
