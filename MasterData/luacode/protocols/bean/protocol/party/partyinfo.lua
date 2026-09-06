local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local PartyInfo = dataclass("PartyInfo")
PartyInfo.partyId = 0
PartyInfo.enterNum = 0
PartyInfo.totalNum = 0
PartyInfo.avatarId = 0
PartyInfo.partyName = ""
PartyInfo.partyLv = 0
PartyInfo.partyExp = 0
PartyInfo.autoAcceptApply = 0
PartyInfo.AUTO = 1
PartyInfo.MANUAL = 0

function PartyInfo:Ctor()
end

function PartyInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.enterNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.partyLv) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.partyExp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

function PartyInfo:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.enterNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.partyName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.partyLv = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.partyExp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.autoAcceptApply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return PartyInfo
