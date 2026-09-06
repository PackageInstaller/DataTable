local SSkillEnd = dataclass("SSkillEnd")
SSkillEnd.ProtocolType = 20
SSkillEnd.skillid = 0

function SSkillEnd:Ctor(client)
end

function SSkillEnd:Marshal(data)
  data.skillid = self.skillid
end

function SSkillEnd:Unmarshal(data)
  self.skillid = data.skillid
  return true
end

function SSkillEnd:CheckVariable()
  if type(self.skillid) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.skillid) = %s. number required.", type(self.skillid))
    return false
  end
  return true
end

return SSkillEnd
