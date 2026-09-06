local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CIslandTouchAltar = dataclass("CIslandTouchAltar", require("framework.net.protocol"))
CIslandTouchAltar.ProtocolType = 1997
CIslandTouchAltar.MaxSize = 65535
CIslandTouchAltar.islandID = 0

function CIslandTouchAltar:Ctor(client)
  CIslandTouchAltar.super.Ctor(self, client)
end

function CIslandTouchAltar:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.islandID) then
    return false
  end
  return true
end

function CIslandTouchAltar:Unmarshal(buffer)
  local ret = true
  ret, self.islandID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CIslandTouchAltar
