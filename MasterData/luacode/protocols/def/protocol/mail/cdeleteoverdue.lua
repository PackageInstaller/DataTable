local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteOverdue = dataclass("CDeleteOverdue", require("framework.net.protocol"))
CDeleteOverdue.ProtocolType = 1413
CDeleteOverdue.MaxSize = 65535

function CDeleteOverdue:Ctor(client)
  CDeleteOverdue.super.Ctor(self, client)
end

function CDeleteOverdue:Marshal(buffer)
  return true
end

function CDeleteOverdue:Unmarshal(buffer)
  local ret = true
  return ret
end

return CDeleteOverdue
