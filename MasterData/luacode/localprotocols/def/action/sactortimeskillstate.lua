local SActorTimeSkillState = dataclass("SActorTimeSkillState")
SActorTimeSkillState.ProtocolType = 52
SActorTimeSkillState.state = 0

function SActorTimeSkillState:Ctor(client)
end

function SActorTimeSkillState:Marshal(data)
  data.state = self.state
end

function SActorTimeSkillState:Unmarshal(data)
  self.state = data.state
  return true
end

function SActorTimeSkillState:CheckVariable()
  if type(self.state) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.state) = %s. number required.", type(self.state))
    return false
  end
  return true
end

return SActorTimeSkillState
