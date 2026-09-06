local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local PartyBossDamageRecord = dataclass("PartyBossDamageRecord")
PartyBossDamageRecord.username = ""
PartyBossDamageRecord.bossid = 0
PartyBossDamageRecord.damage = 0
PartyBossDamageRecord.ts = 0
PartyBossDamageRecord.ifkill = 0

function PartyBossDamageRecord:Ctor()
end

function PartyBossDamageRecord:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.username) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.damage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.ts) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ifkill) then
    return false
  end
  return true
end

function PartyBossDamageRecord:Unmarshal(buffer)
  local ret = true
  ret, self.username = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.bossid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.damage = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.ts = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.ifkill = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyBossDamageRecord
