local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCollectLampStand = dataclass("CCollectLampStand", require("framework.net.protocol"))
CCollectLampStand.ProtocolType = 2335
CCollectLampStand.MaxSize = 65535

function CCollectLampStand:Ctor(client)
  CCollectLampStand.super.Ctor(self, client)
end

function CCollectLampStand:Marshal(buffer)
  return true
end

function CCollectLampStand:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCollectLampStand
