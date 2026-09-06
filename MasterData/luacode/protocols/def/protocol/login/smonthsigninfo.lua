local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMonthSignInfo = dataclass("SMonthSignInfo", require("framework.net.protocol"))
SMonthSignInfo.ProtocolType = 1091
SMonthSignInfo.MaxSize = 65535
SMonthSignInfo.signTotalNum = 0

function SMonthSignInfo:Ctor(client)
  SMonthSignInfo.super.Ctor(self, client)
  self.receives = {}
end

function SMonthSignInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.signTotalNum) then
    return false
  end
  local length = table.slen(self.receives)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receives[i]) then
      return false
    end
  end
  return true
end

function SMonthSignInfo:Unmarshal(buffer)
  local ret = true
  ret, self.signTotalNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receives[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SMonthSignInfo
