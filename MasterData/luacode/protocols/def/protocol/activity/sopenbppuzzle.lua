local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenBpPuzzle = dataclass("SOpenBpPuzzle", require("framework.net.protocol"))
SOpenBpPuzzle.ProtocolType = 2672
SOpenBpPuzzle.MaxSize = 65535
SOpenBpPuzzle.Id = 0
SOpenBpPuzzle.leftTime = 0

function SOpenBpPuzzle:Ctor(client)
  SOpenBpPuzzle.super.Ctor(self, client)
  self.unlockedPuzzle = {}
  self.receivedAward = {}
end

function SOpenBpPuzzle:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.Id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  local length = table.slen(self.unlockedPuzzle)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.unlockedPuzzle[i]) then
      return false
    end
  end
  local length = table.slen(self.receivedAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receivedAward[i]) then
      return false
    end
  end
  return true
end

function SOpenBpPuzzle:Unmarshal(buffer)
  local ret = true
  ret, self.Id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.unlockedPuzzle[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receivedAward[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SOpenBpPuzzle
