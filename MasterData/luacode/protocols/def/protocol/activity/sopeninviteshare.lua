local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenInviteShare = dataclass("SOpenInviteShare", require("framework.net.protocol"))
SOpenInviteShare.ProtocolType = 2466
SOpenInviteShare.MaxSize = 65535
SOpenInviteShare.invitationCode = ""
SOpenInviteShare.weekshare = 0
SOpenInviteShare.inviteeNum = 0
SOpenInviteShare.limitNum = 0

function SOpenInviteShare:Ctor(client)
  SOpenInviteShare.super.Ctor(self, client)
end

function SOpenInviteShare:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.invitationCode) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.weekshare) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.inviteeNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.limitNum) then
    return false
  end
  return true
end

function SOpenInviteShare:Unmarshal(buffer)
  local ret = true
  ret, self.invitationCode = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.weekshare = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.inviteeNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.limitNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenInviteShare
