local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FoolsDayCopyBattle = dataclass("FoolsDayCopyBattle")
FoolsDayCopyBattle.bossId = 0
FoolsDayCopyBattle.leftTimes = 0

function FoolsDayCopyBattle:Ctor()
  self.difficult = {}
end

function FoolsDayCopyBattle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.bossId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.leftTimes) then
    return false
  end
  local length = table.slen(self.difficult)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.difficult[i]) then
      return false
    end
  end
  return true
end

function FoolsDayCopyBattle:Unmarshal(buffer)
  local ret = true
  ret, self.bossId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.difficult[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return FoolsDayCopyBattle
