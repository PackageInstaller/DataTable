-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/cdrawcard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDrawCard = dataclass("CDrawCard", require("framework.net.protocol"))
CDrawCard.ProtocolType = 1503
CDrawCard.MaxSize = 65535
CDrawCard.WaitProtocol = "protocol.notify.scancelloading"
CDrawCard.poolId = 0
CDrawCard.drawType = 0
CDrawCard.costType = 0
CDrawCard.TYPE_ONE = 1
CDrawCard.TYPE_TEN = 2
CDrawCard.TYPE_TWO = 3
CDrawCard.TYPE_CHARGE_TEN = 4
CDrawCard.ITEM_COST_SOUL = 1
CDrawCard.ITEM_COST_ORDINARY = 2
CDrawCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDrawCard
  ((CDrawCard.super).Ctor)(self, client)
end

CDrawCard.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.poolId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.drawType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.costType) then
    return false
  end
  return true
end

CDrawCard.Unmarshal = function(self, buffer)
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

return CDrawCard

