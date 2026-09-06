local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLoverRedPoint = dataclass("SLoverRedPoint", require("framework.net.protocol"))
SLoverRedPoint.ProtocolType = 2610
SLoverRedPoint.MaxSize = 65535
SLoverRedPoint.state = 0
SLoverRedPoint.LOVER_CHOCOLATE = 1
SLoverRedPoint.LOVER_FLOWER = 2

function SLoverRedPoint:Ctor(client)
  SLoverRedPoint.super.Ctor(self, client)
end

function SLoverRedPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SLoverRedPoint:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLoverRedPoint
