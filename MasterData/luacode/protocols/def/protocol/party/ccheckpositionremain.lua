local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckPositionRemain = dataclass("CCheckPositionRemain", require("framework.net.protocol"))
CCheckPositionRemain.ProtocolType = 5024
CCheckPositionRemain.MaxSize = 65535
CCheckPositionRemain.partyId = 0

function CCheckPositionRemain:Ctor(client)
  CCheckPositionRemain.super.Ctor(self, client)
end

function CCheckPositionRemain:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  return true
end

function CCheckPositionRemain:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPositionRemain
