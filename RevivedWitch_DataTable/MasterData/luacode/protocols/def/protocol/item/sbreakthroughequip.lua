-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sbreakthroughequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBreakThroughEquip = dataclass("SBreakThroughEquip", require("framework.net.protocol"))
SBreakThroughEquip.ProtocolType = 1242
SBreakThroughEquip.MaxSize = 65535
SBreakThroughEquip.equipKey = 0
SBreakThroughEquip.stage = 0
SBreakThroughEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBreakThroughEquip
  ((SBreakThroughEquip.super).Ctor)(self, client)
end

SBreakThroughEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
    return false
  end
  return true
end

SBreakThroughEquip.Unmarshal = function(self, buffer)
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

return SBreakThroughEquip

