local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCollectLightSpot = dataclass("SCollectLightSpot", require("framework.net.protocol"))
SCollectLightSpot.ProtocolType = 2345
SCollectLightSpot.MaxSize = 65535

function SCollectLightSpot:Ctor(client)
  SCollectLightSpot.super.Ctor(self, client)
  self.light = require("protocols.bean.protocol.yard.light").Create()
end

function SCollectLightSpot:Marshal(buffer)
  if not self.light:Marshal(buffer) then
    return false
  end
  return true
end

function SCollectLightSpot:Unmarshal(buffer)
  local ret = true
  if not self.light:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SCollectLightSpot
