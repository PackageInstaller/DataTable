-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/shop/goodinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local GoodInfo = dataclass("GoodInfo")
GoodInfo.goodId = 0
GoodInfo.sortId = 0
GoodInfo.itemId = 0
GoodInfo.itemSum = 0
GoodInfo.goodRemain = 0
GoodInfo.maxRemain = 0
GoodInfo.moneyType = 0
GoodInfo.price = 0
GoodInfo.discount = 0
GoodInfo.discountPrice = 0
GoodInfo.beginTime = 0
GoodInfo.endTime = 0
GoodInfo.status = 0
GoodInfo.NORMAL = 0
GoodInfo.OVER_LIMIT = 1
GoodInfo.Ctor = function(self)
  -- function num : 0_0
end

GoodInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sortId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemSum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodRemain) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.maxRemain) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.moneyType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.price) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.discount) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.discountPrice) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.beginTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  return true
end

GoodInfo.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return GoodInfo

