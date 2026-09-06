local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshMailRedPoint = dataclass("SRefreshMailRedPoint", require("framework.net.protocol"))
SRefreshMailRedPoint.ProtocolType = 2534
SRefreshMailRedPoint.MaxSize = 65535
SRefreshMailRedPoint.redPoint = 0

function SRefreshMailRedPoint:Ctor(client)
  SRefreshMailRedPoint.super.Ctor(self, client)
end

function SRefreshMailRedPoint:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redPoint) then
    return false
  end
  return true
end

function SRefreshMailRedPoint:Unmarshal(buffer)
  local ret = true
  ret, self.redPoint = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshMailRedPoint
