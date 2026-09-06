local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRandomLightSpot = dataclass("CRandomLightSpot", require("framework.net.protocol"))
CRandomLightSpot.ProtocolType = 2342
CRandomLightSpot.MaxSize = 65535

function CRandomLightSpot:Ctor(client)
  CRandomLightSpot.super.Ctor(self, client)
end

function CRandomLightSpot:Marshal(buffer)
  return true
end

function CRandomLightSpot:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRandomLightSpot
