local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRemoveMember = dataclass("CRemoveMember", require("framework.net.protocol"))
CRemoveMember.ProtocolType = 5018
CRemoveMember.MaxSize = 65535
CRemoveMember.partyId = 0
CRemoveMember.userId = 0

function CRemoveMember:Ctor(client)
  CRemoveMember.super.Ctor(self, client)
end

function CRemoveMember:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CRemoveMember:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRemoveMember
