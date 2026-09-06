local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CVisitNpc = dataclass("CVisitNpc", require("framework.net.protocol"))
CVisitNpc.ProtocolType = 2001
CVisitNpc.MaxSize = 65535
CVisitNpc.npcId = 0

function CVisitNpc:Ctor(client)
  CVisitNpc.super.Ctor(self, client)
end

function CVisitNpc:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.npcId) then
    return false
  end
  return true
end

function CVisitNpc:Unmarshal(buffer)
  local ret = true
  ret, self.npcId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CVisitNpc
