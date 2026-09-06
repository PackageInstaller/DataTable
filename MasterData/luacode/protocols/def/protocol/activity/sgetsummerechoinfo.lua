local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSummerEchoInfo = dataclass("SGetSummerEchoInfo", require("framework.net.protocol"))
SGetSummerEchoInfo.ProtocolType = 2704
SGetSummerEchoInfo.MaxSize = 65535
SGetSummerEchoInfo.firstEnter = 0
SGetSummerEchoInfo.snackRedpoint = 0
SGetSummerEchoInfo.activityLeftTime = 0

function SGetSummerEchoInfo:Ctor(client)
  SGetSummerEchoInfo.super.Ctor(self, client)
  self.constructions = {}
end

function SGetSummerEchoInfo:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.snackRedpoint) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.activityLeftTime) then
    return false
  end
  return true
end

function SGetSummerEchoInfo:Unmarshal(buffer)
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
    self.constructions[i] = require("protocols.bean.protocol.activity.summerechoconstruction").Create()
    if not self.constructions[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.snackRedpoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.activityLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetSummerEchoInfo
