local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenBackPack = dataclass("SOpenBackPack", require("framework.net.protocol"))
SOpenBackPack.ProtocolType = 2556
SOpenBackPack.MaxSize = 65535
SOpenBackPack.allSpirt = 0
SOpenBackPack.leftTime = 0

function SOpenBackPack:Ctor(client)
  SOpenBackPack.super.Ctor(self, client)
  self.spirtLimit = {}
  self.goodInfo = {}
end

function SOpenBackPack:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.allSpirt) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  local length = table.slen(self.spirtLimit)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.spirtLimit[i]) then
      return false
    end
  end
  local length = table.slen(self.goodInfo)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.goodInfo[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SOpenBackPack:Unmarshal(buffer)
  local ret = true
  ret, self.allSpirt = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    ret, self.spirtLimit[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
    self.goodInfo[i] = require("protocols.bean.protocol.activity.goodinfo").Create()
    if not self.goodInfo[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SOpenBackPack
