local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChristmasSupportRedPoint = dataclass("SChristmasSupportRedPoint", require("framework.net.protocol"))
SChristmasSupportRedPoint.ProtocolType = 2572
SChristmasSupportRedPoint.MaxSize = 65535
SChristmasSupportRedPoint.STAGE = 1
SChristmasSupportRedPoint.TOTAL_CALL = 2
SChristmasSupportRedPoint.RANKING = 3
SChristmasSupportRedPoint.FREE_GOOD = 4

function SChristmasSupportRedPoint:Ctor(client)
  SChristmasSupportRedPoint.super.Ctor(self, client)
  self.state = {}
end

function SChristmasSupportRedPoint:Marshal(buffer)
  local length = table.slen(self.state)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state[i]) then
      return false
    end
  end
  return true
end

function SChristmasSupportRedPoint:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.state[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SChristmasSupportRedPoint
