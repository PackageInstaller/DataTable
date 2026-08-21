-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cdecomposeitems.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDecomposeItems = dataclass("CDecomposeItems", require("framework.net.protocol"))
CDecomposeItems.ProtocolType = 1206
CDecomposeItems.MaxSize = 65535
CDecomposeItems.itemId = 0
CDecomposeItems.ItemNum = 0
CDecomposeItems.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDecomposeItems
  ((CDecomposeItems.super).Ctor)(self, client)
end

CDecomposeItems.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.ItemNum) then
    return false
  end
  return true
end

CDecomposeItems.Unmarshal = function(self, buffer)
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

return CDecomposeItems

