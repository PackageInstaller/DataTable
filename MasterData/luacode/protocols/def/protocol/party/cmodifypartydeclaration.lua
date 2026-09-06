local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CModifyPartyDeclaration = dataclass("CModifyPartyDeclaration", require("framework.net.protocol"))
CModifyPartyDeclaration.ProtocolType = 5007
CModifyPartyDeclaration.MaxSize = 65535
CModifyPartyDeclaration.partyId = 0
CModifyPartyDeclaration.partyDeclaration = ""

function CModifyPartyDeclaration:Ctor(client)
  CModifyPartyDeclaration.super.Ctor(self, client)
end

function CModifyPartyDeclaration:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyDeclaration) then
    return false
  end
  return true
end

function CModifyPartyDeclaration:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.partyDeclaration = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CModifyPartyDeclaration
