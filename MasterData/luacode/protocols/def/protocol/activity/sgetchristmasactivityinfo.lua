local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetChristmasActivityInfo = dataclass("SGetChristmasActivityInfo", require("framework.net.protocol"))
SGetChristmasActivityInfo.ProtocolType = 2526
SGetChristmasActivityInfo.MaxSize = 65535
SGetChristmasActivityInfo.firstEnter = 0
SGetChristmasActivityInfo.stage = 0
SGetChristmasActivityInfo.canEnterSecond = 0

function SGetChristmasActivityInfo:Ctor(client)
  SGetChristmasActivityInfo.super.Ctor(self, client)
  self.constructions = {}
end

function SGetChristmasActivityInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstEnter) then
    return false
  end
  local length = table.slen(self.constructions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.constructions[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.stage) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canEnterSecond) then
    return false
  end
  return true
end

function SGetChristmasActivityInfo:Unmarshal(buffer)
  local ret = true
  ret, self.firstEnter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.constructions[i] = require("protocols.bean.protocol.activity.christmasconstruction").Create()
    if not self.constructions[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.stage = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.canEnterSecond = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetChristmasActivityInfo
