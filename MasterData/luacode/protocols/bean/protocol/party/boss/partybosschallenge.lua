local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local PartyBossChallenge = dataclass("PartyBossChallenge")
PartyBossChallenge.rank = 0
PartyBossChallenge.id = 0
PartyBossChallenge.name = ""
PartyBossChallenge.lv = 0
PartyBossChallenge.score = 0
PartyBossChallenge.extra = 0
PartyBossChallenge.avatarId = 0
PartyBossChallenge.frameId = 0
PartyBossChallenge.NOT_ON_LIST = -1
PartyBossChallenge.NOT_Challenge = -2

function PartyBossChallenge:Ctor()
end

function PartyBossChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rank) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.lv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.extra) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.frameId) then
    return false
  end
  return true
end

function PartyBossChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.rank = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.lv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.extra = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.frameId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyBossChallenge
