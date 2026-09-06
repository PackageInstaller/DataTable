local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CStartAutoExplore = dataclass("CStartAutoExplore", require("framework.net.protocol"))
CStartAutoExplore.ProtocolType = 1963
CStartAutoExplore.MaxSize = 65535
CStartAutoExplore.zoneId = 0
CStartAutoExplore.dungeonType = 0

function CStartAutoExplore:Ctor(client)
  CStartAutoExplore.super.Ctor(self, client)
end

function CStartAutoExplore:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.zoneId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dungeonType) then
    return false
  end
  return true
end

function CStartAutoExplore:Unmarshal(buffer)
  local ret = true
  ret, self.zoneId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dungeonType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartAutoExplore
