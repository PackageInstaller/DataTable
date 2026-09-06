local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SModifyAutoAccept = dataclass("SModifyAutoAccept", require("framework.net.protocol"))
SModifyAutoAccept.ProtocolType = 5014
SModifyAutoAccept.MaxSize = 65535
SModifyAutoAccept.partyId = 0
SModifyAutoAccept.autoAcceptApply = 0

function SModifyAutoAccept:Ctor(client)
  SModifyAutoAccept.super.Ctor(self, client)
end

function SModifyAutoAccept:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoAcceptApply) then
    return false
  end
  return true
end

function SModifyAutoAccept:Unmarshal(buffer)
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

return SModifyAutoAccept
