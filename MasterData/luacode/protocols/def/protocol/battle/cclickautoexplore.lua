local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CClickAutoExplore = dataclass("CClickAutoExplore", require("framework.net.protocol"))
CClickAutoExplore.ProtocolType = 4122
CClickAutoExplore.MaxSize = 65535
CClickAutoExplore.zoneId = 0

function CClickAutoExplore:Ctor(client)
  CClickAutoExplore.super.Ctor(self, client)
end

function CClickAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneId) then
    return false
  end
  return true
end

function CClickAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.zoneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CClickAutoExplore
