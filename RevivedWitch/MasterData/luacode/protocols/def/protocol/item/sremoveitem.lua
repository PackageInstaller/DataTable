-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sremoveitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRemoveItem = dataclass("SRemoveItem", require("framework.net.protocol"))
SRemoveItem.ProtocolType = 1203
SRemoveItem.MaxSize = 65535
SRemoveItem.bagType = 0
SRemoveItem.itemKey = 0
SRemoveItem.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRemoveItem
  ((SRemoveItem.super).Ctor)(self, client)
end

SRemoveItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.bagType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemKey) then
    return false
  end
  return true
end

SRemoveItem.Unmarshal = function(self, buffer)
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
  return ret
end

return SRemoveItem

