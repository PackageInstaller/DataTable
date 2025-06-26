-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/crefreshfriendshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRefreshFriendShop = dataclass("CRefreshFriendShop", require("framework.net.protocol"))
CRefreshFriendShop.ProtocolType = 3620
CRefreshFriendShop.MaxSize = 65535
CRefreshFriendShop.shopType = 0
CRefreshFriendShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRefreshFriendShop
  ((CRefreshFriendShop.super).Ctor)(self, client)
end

CRefreshFriendShop.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopType) then
    return false
  end
  return true
end

CRefreshFriendShop.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRefreshFriendShop

