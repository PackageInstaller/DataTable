local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCloseShatteredRedPoint = dataclass("CCloseShatteredRedPoint", require("framework.net.protocol"))
CCloseShatteredRedPoint.ProtocolType = 4134
CCloseShatteredRedPoint.MaxSize = 65535

function CCloseShatteredRedPoint:Ctor(client)
  CCloseShatteredRedPoint.super.Ctor(self, client)
end

function CCloseShatteredRedPoint:Marshal(buffer)
  return true
end

function CCloseShatteredRedPoint:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCloseShatteredRedPoint
