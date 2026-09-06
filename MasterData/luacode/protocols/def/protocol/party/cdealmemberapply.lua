local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDealMemberApply = dataclass("CDealMemberApply", require("framework.net.protocol"))
CDealMemberApply.ProtocolType = 5012
CDealMemberApply.MaxSize = 65535
CDealMemberApply.partyId = 0
CDealMemberApply.userId = 0
CDealMemberApply.operate = 0
CDealMemberApply.REFUSE = 0
CDealMemberApply.ACCEPT = 1

function CDealMemberApply:Ctor(client)
  CDealMemberApply.super.Ctor(self, client)
end

function CDealMemberApply:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  return true
end

function CDealMemberApply:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDealMemberApply
