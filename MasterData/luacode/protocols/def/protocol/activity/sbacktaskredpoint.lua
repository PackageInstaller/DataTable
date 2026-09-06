local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBackTaskRedPoint = dataclass("SBackTaskRedPoint", require("framework.net.protocol"))
SBackTaskRedPoint.ProtocolType = 2573
SBackTaskRedPoint.MaxSize = 65535

function SBackTaskRedPoint:Ctor(client)
  SBackTaskRedPoint.super.Ctor(self, client)
end

function SBackTaskRedPoint:Marshal(buffer)
  return true
end

function SBackTaskRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SBackTaskRedPoint
