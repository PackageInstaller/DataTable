local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SModifyPartyDeclaration = dataclass("SModifyPartyDeclaration", require("framework.net.protocol"))
SModifyPartyDeclaration.ProtocolType = 5026
SModifyPartyDeclaration.MaxSize = 65535
SModifyPartyDeclaration.partyDeclaration = ""

function SModifyPartyDeclaration:Ctor(client)
  SModifyPartyDeclaration.super.Ctor(self, client)
end

function SModifyPartyDeclaration:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyDeclaration) then
    return false
  end
  return true
end

function SModifyPartyDeclaration:Unmarshal(buffer)
  local ret = true
  ret, self.partyDeclaration = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SModifyPartyDeclaration
