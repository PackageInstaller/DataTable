-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/card/cardinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CardInfo = dataclass("CardInfo")
CardInfo.cardtype = 0
CardInfo.cardId = 0
CardInfo.isNew = 0
CardInfo.ITEM = 1
CardInfo.ROLE = 2
CardInfo.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.item = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
end

CardInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cardtype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.cardId) then
    return false
  end
  if not (self.item):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isNew) then
    return false
  end
  return true
end

CardInfo.Unmarshal = function(self, buffer)
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
  if not (self.item):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CardInfo

