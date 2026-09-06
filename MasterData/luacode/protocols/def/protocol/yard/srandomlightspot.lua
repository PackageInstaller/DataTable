local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRandomLightSpot = dataclass("SRandomLightSpot", require("framework.net.protocol"))
SRandomLightSpot.ProtocolType = 2343
SRandomLightSpot.MaxSize = 65535
SRandomLightSpot.leftNextRandomLightSpotTime = 0

function SRandomLightSpot:Ctor(client)
  SRandomLightSpot.super.Ctor(self, client)
  self.light = require("protocols.bean.protocol.yard.light").Create()
end

function SRandomLightSpot:Marshal(buffer)
  if not self.light:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftNextRandomLightSpotTime) then
    return false
  end
  return true
end

function SRandomLightSpot:Unmarshal(buffer)
  local ret = true
  if not self.light:Unmarshal(buffer) then
    return false
  end
  ret, self.leftNextRandomLightSpotTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRandomLightSpot
