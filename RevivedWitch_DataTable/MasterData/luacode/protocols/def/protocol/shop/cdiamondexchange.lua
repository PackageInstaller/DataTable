-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cdiamondexchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDiamondExchange = dataclass("CDiamondExchange", require("framework.net.protocol"))
CDiamondExchange.ProtocolType = 3626
CDiamondExchange.MaxSize = 65535
CDiamondExchange.costItem = 0
CDiamondExchange.costItemSum = 0
CDiamondExchange.exchangeCurrencyType = 0
CDiamondExchange.exchangeCurrencySum = 0
CDiamondExchange.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDiamondExchange
  ((CDiamondExchange.super).Ctor)(self, client)
end

CDiamondExchange.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.costItem) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.costItemSum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.exchangeCurrencyType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.exchangeCurrencySum) then
    return false
  end
  return true
end

CDiamondExchange.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDiamondExchange

