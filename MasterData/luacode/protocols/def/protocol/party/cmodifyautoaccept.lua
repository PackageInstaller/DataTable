local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CModifyAutoAccept = dataclass("CModifyAutoAccept", require("framework.net.protocol"))
CModifyAutoAccept.ProtocolType = 5013
CModifyAutoAccept.MaxSize = 65535
CModifyAutoAccept.partyId = 0
CModifyAutoAccept.autoAcceptApply = 0

function CModifyAutoAccept:Ctor(client)
  CModifyAutoAccept.super.Ctor(self, client)
end

function CModifyAutoAccept:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

function CModifyAutoAccept:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.autoAcceptApply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CModifyAutoAccept
