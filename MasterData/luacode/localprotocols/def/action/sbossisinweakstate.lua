local SBossIsInWeakState = dataclass("SBossIsInWeakState")
SBossIsInWeakState.ProtocolType = 48

function SBossIsInWeakState:Ctor(client)
end

function SBossIsInWeakState:Marshal(data)
end

function SBossIsInWeakState:Unmarshal(data)
  return true
end

function SBossIsInWeakState:CheckVariable()
  return true
end

return SBossIsInWeakState
