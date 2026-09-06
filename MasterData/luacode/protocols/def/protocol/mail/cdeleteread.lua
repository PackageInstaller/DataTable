local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteRead = dataclass("CDeleteRead", require("framework.net.protocol"))
CDeleteRead.ProtocolType = 1409
CDeleteRead.MaxSize = 65535

function CDeleteRead:Ctor(client)
  CDeleteRead.super.Ctor(self, client)
end

function CDeleteRead:Marshal(buffer)
  return true
end

function CDeleteRead:Unmarshal(buffer)
  local ret = true
  return ret
end

return CDeleteRead
