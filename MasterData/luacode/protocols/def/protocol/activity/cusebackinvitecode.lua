local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUseBackInviteCode = dataclass("CUseBackInviteCode", require("framework.net.protocol"))
CUseBackInviteCode.ProtocolType = 2551
CUseBackInviteCode.MaxSize = 65535
CUseBackInviteCode.invitationCode = ""

function CUseBackInviteCode:Ctor(client)
  CUseBackInviteCode.super.Ctor(self, client)
end

function CUseBackInviteCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.invitationCode) then
    return false
  end
  return true
end

function CUseBackInviteCode:Unmarshal(buffer)
  local ret = true
  ret, self.invitationCode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseBackInviteCode
