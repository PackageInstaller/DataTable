local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUseInvitationCode = dataclass("SUseInvitationCode", require("framework.net.protocol"))
SUseInvitationCode.ProtocolType = 2457
SUseInvitationCode.MaxSize = 65535
SUseInvitationCode.result = 0
SUseInvitationCode.invitationCode = ""
SUseInvitationCode.fail = 0
SUseInvitationCode.success = 1

function SUseInvitationCode:Ctor(client)
  SUseInvitationCode.super.Ctor(self, client)
end

function SUseInvitationCode:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.invitationCode) then
    return false
  end
  return true
end

function SUseInvitationCode:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.invitationCode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUseInvitationCode
