local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDeleteFriend = dataclass("CDeleteFriend", require("framework.net.protocol"))
CDeleteFriend.ProtocolType = 1125
CDeleteFriend.MaxSize = 65535
CDeleteFriend.userId = 0

function CDeleteFriend:Ctor(client)
  CDeleteFriend.super.Ctor(self, client)
end

function CDeleteFriend:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.userId) then
    return false
  end
  return true
end

function CDeleteFriend:Unmarshal(buffer)
  local ret = true
  ret, self.userId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteFriend
