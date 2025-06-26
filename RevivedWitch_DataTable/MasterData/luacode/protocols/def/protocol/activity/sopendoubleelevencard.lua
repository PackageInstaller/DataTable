-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopendoubleelevencard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenDoubleElevenCard = dataclass("SOpenDoubleElevenCard", require("framework.net.protocol"))
SOpenDoubleElevenCard.ProtocolType = 2524
SOpenDoubleElevenCard.MaxSize = 65535
SOpenDoubleElevenCard.poolId = 0
SOpenDoubleElevenCard.position = 0
SOpenDoubleElevenCard.cardType = 0
SOpenDoubleElevenCard.NORMAL_CARD = 0
SOpenDoubleElevenCard.GOLD_CARD = 1
SOpenDoubleElevenCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenDoubleElevenCard, _ENV
  ((SOpenDoubleElevenCard.super).Ctor)(self, client)
  self.itemInfo = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
end

SOpenDoubleElevenCard.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.poolId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.position) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cardType) then
    return false
  end
  if not (self.itemInfo):Marshal(buffer) then
    return false
  end
  return true
end

SOpenDoubleElevenCard.Unmarshal = function(self, buffer)
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
  if not (self.itemInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenDoubleElevenCard

