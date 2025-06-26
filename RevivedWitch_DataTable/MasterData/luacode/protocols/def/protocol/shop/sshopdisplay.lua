-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sshopdisplay.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SShopDisplay = dataclass("SShopDisplay", require("framework.net.protocol"))
SShopDisplay.ProtocolType = 3648
SShopDisplay.MaxSize = 65535
SShopDisplay.shopType = 0
SShopDisplay.isMask = 0
SShopDisplay.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SShopDisplay
  ((SShopDisplay.super).Ctor)(self, client)
end

SShopDisplay.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteByte)(buffer, self.isMask) then
    return false
  end
  return true
end

SShopDisplay.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadByte)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShopDisplay

