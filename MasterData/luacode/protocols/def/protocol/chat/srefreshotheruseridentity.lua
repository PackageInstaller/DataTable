local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshOtherUserIdentity = dataclass("SRefreshOtherUserIdentity", require("framework.net.protocol"))
SRefreshOtherUserIdentity.ProtocolType = 1128
SRefreshOtherUserIdentity.MaxSize = 65535
SRefreshOtherUserIdentity.userId = 0
SRefreshOtherUserIdentity.identity = 0

function SRefreshOtherUserIdentity:Ctor(client)
  SRefreshOtherUserIdentity.super.Ctor(self, client)
end

function SRefreshOtherUserIdentity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.identity) then
    return false
  end
  return true
end

function SRefreshOtherUserIdentity:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.identity = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRefreshOtherUserIdentity
