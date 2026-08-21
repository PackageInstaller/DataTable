-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/scheckshopredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCheckShopRedpoint = dataclass("SCheckShopRedpoint", require("framework.net.protocol"))
SCheckShopRedpoint.ProtocolType = 3640
SCheckShopRedpoint.MaxSize = 65535
SCheckShopRedpoint.shoptype = 0
SCheckShopRedpoint.goodId = 0
SCheckShopRedpoint.canDo = 0
SCheckShopRedpoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCheckShopRedpoint
  ((SCheckShopRedpoint.super).Ctor)(self, client)
end

SCheckShopRedpoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shoptype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.canDo) then
    return false
  end
  return true
end

SCheckShopRedpoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCheckShopRedpoint

