local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRequestRougeTowerOpen = dataclass("CRequestRougeTowerOpen", require("framework.net.protocol"))
CRequestRougeTowerOpen.ProtocolType = 2492
CRequestRougeTowerOpen.MaxSize = 65535

function CRequestRougeTowerOpen:Ctor(client)
  CRequestRougeTowerOpen.super.Ctor(self, client)
end

function CRequestRougeTowerOpen:Marshal(buffer)
  return true
end

function CRequestRougeTowerOpen:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRequestRougeTowerOpen
