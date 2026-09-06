local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShatteredRedPoint = dataclass("SShatteredRedPoint", require("framework.net.protocol"))
SShatteredRedPoint.ProtocolType = 4133
SShatteredRedPoint.MaxSize = 65535

function SShatteredRedPoint:Ctor(client)
  SShatteredRedPoint.super.Ctor(self, client)
end

function SShatteredRedPoint:Marshal(buffer)
  return true
end

function SShatteredRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return SShatteredRedPoint
