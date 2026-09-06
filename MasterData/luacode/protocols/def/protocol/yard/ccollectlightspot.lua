local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCollectLightSpot = dataclass("CCollectLightSpot", require("framework.net.protocol"))
CCollectLightSpot.ProtocolType = 2344
CCollectLightSpot.MaxSize = 65535
CCollectLightSpot.key = 0

function CCollectLightSpot:Ctor(client)
  CCollectLightSpot.super.Ctor(self, client)
end

function CCollectLightSpot:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CCollectLightSpot:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCollectLightSpot
