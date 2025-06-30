-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sbuydiamondgood.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBuyDiamondGood = dataclass("SBuyDiamondGood", require("framework.net.protocol"))
SBuyDiamondGood.ProtocolType = 3618
SBuyDiamondGood.MaxSize = 65535
SBuyDiamondGood.result = 0
SBuyDiamondGood.shopId = 0
SBuyDiamondGood.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBuyDiamondGood, _ENV
  ((SBuyDiamondGood.super).Ctor)(self, client)
  self.refresh = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
end

SBuyDiamondGood.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopId) then
    return false
  end
  if not (self.refresh):Marshal(buffer) then
    return false
  end
  return true
end

SBuyDiamondGood.Unmarshal = function(self, buffer)
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
  if not (self.refresh):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SBuyDiamondGood

