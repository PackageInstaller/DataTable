local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRefreshFriendShop = dataclass("CRefreshFriendShop", require("framework.net.protocol"))
CRefreshFriendShop.ProtocolType = 3620
CRefreshFriendShop.MaxSize = 65535
CRefreshFriendShop.shopType = 0

function CRefreshFriendShop:Ctor(client)
  CRefreshFriendShop.super.Ctor(self, client)
end

function CRefreshFriendShop:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.shopType) then
    return false
  end
  return true
end

function CRefreshFriendShop:Unmarshal(buffer)
  local ret = true
  ret, self.shopType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRefreshFriendShop
