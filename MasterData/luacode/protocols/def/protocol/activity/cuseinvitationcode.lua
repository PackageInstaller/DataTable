local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUseInvitationCode = dataclass("CUseInvitationCode", require("framework.net.protocol"))
CUseInvitationCode.ProtocolType = 2456
CUseInvitationCode.MaxSize = 65535
CUseInvitationCode.invitationCode = ""

function CUseInvitationCode:Ctor(client)
  CUseInvitationCode.super.Ctor(self, client)
end

function CUseInvitationCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.invitationCode) then
    return false
  end
  return true
end

function CUseInvitationCode:Unmarshal(buffer)
  local ret = true
  ret, self.invitationCode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseInvitationCode
