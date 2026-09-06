local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local PartyBossState = dataclass("PartyBossState")
PartyBossState.bossid = 0
PartyBossState.state = 0
PartyBossState.hp = 0
PartyBossState.mymaxdamage = 0

function PartyBossState:Ctor()
end

function PartyBossState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.hp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.mymaxdamage) then
    return false
  end
  return true
end

function PartyBossState:Unmarshal(buffer)
  local ret = true
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.hp = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.mymaxdamage = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyBossState
