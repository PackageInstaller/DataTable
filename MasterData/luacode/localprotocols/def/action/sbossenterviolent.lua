local SBossEnterViolent = dataclass("SBossEnterViolent")
SBossEnterViolent.ProtocolType = 63

function SBossEnterViolent:Ctor(client)
end

function SBossEnterViolent:Marshal(data)
end

function SBossEnterViolent:Unmarshal(data)
  return true
end

function SBossEnterViolent:CheckVariable()
  return true
end

return SBossEnterViolent
