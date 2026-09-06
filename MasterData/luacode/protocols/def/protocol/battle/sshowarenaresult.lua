local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowArenaResult = dataclass("SShowArenaResult", require("framework.net.protocol"))
SShowArenaResult.ProtocolType = 4117
SShowArenaResult.MaxSize = 65535
SShowArenaResult.victory = 0
SShowArenaResult.arenaId = 0
SShowArenaResult.camp = 0
SShowArenaResult.totalNum = 0
SShowArenaResult.victoryNum = 0
SShowArenaResult.pithy = 0
SShowArenaResult.totalPithy = 0
SShowArenaResult.open = 0

function SShowArenaResult:Ctor(client)
  SShowArenaResult.super.Ctor(self, client)
  self.campsResult = {}
  self.reward = {}
end

function SShowArenaResult:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.victory) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.arenaId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.camp) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.campsResult)) then
    return false
  end
  for key, value in pairs(self.campsResult) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.victoryNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.pithy) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.totalPithy) then
    return false
  end
  local length = table.slen(self.reward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.reward[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.open) then
    return false
  end
  return true
end

function SShowArenaResult:Unmarshal(buffer)
  local ret = true
  ret, self.victory = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.arenaId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.camp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
    self.campsResult[key] = value
  end
  ret, self.totalNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.victoryNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.pithy = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.totalPithy = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.reward[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.reward[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.open = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowArenaResult
