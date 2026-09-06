local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLikeFriends = dataclass("SLikeFriends", require("framework.net.protocol"))
SLikeFriends.ProtocolType = 1139
SLikeFriends.MaxSize = 65535
SLikeFriends.userId = 0

function SLikeFriends:Ctor(client)
  SLikeFriends.super.Ctor(self, client)
end

function SLikeFriends:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function SLikeFriends:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SLikeFriends
