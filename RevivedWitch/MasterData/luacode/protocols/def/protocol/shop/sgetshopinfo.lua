-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sgetshopinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetShopInfo = dataclass("SGetShopInfo", require("framework.net.protocol"))
SGetShopInfo.ProtocolType = 3612
SGetShopInfo.MaxSize = 65535
SGetShopInfo.shopId = 0
SGetShopInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetShopInfo
  ((SGetShopInfo.super).Ctor)(self, client)
  self.goods = {}
  self.rmtGoods = {}
end

SGetShopInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopId) then
    return false
  end
  local length = (table.slen)(self.goods)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.goods)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.rmtGoods)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.rmtGoods)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SGetShopInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.goods)[i] = ((require("protocols.bean.protocol.shop.goodinfo")).Create)()
    if not ((self.goods)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

    (self.rmtGoods)[i] = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
    if not ((self.rmtGoods)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShopInfo

