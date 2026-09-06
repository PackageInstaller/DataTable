local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddFriend = dataclass("CAddFriend", require("framework.net.protocol"))
CAddFriend.ProtocolType = 1124
CAddFriend.MaxSize = 65535
CAddFriend.userId = 0

function CAddFriend:Ctor(client)
  CAddFriend.super.Ctor(self, client)
end

function CAddFriend:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CAddFriend:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddFriend
