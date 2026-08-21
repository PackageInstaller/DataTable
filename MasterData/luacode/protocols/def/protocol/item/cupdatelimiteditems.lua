-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cupdatelimiteditems.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpdateLimitedItems = dataclass("CUpdateLimitedItems", require("framework.net.protocol"))
CUpdateLimitedItems.ProtocolType = 1245
CUpdateLimitedItems.MaxSize = 65535
CUpdateLimitedItems.itemKey = 0
CUpdateLimitedItems.itemId = 0
CUpdateLimitedItems.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpdateLimitedItems
  ((CUpdateLimitedItems.super).Ctor)(self, client)
end

CUpdateLimitedItems.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  return true
end

CUpdateLimitedItems.Unmarshal = function(self, buffer)
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

return CUpdateLimitedItems

