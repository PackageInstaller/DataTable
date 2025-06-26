-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/sviewequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SViewEquip = dataclass("SViewEquip", require("framework.net.protocol"))
SViewEquip.ProtocolType = 1224
SViewEquip.MaxSize = 65535
SViewEquip.key = 0
SViewEquip.viewDetails = 0
SViewEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SViewEquip
  ((SViewEquip.super).Ctor)(self, client)
end

SViewEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.viewDetails) then
    return false
  end
  return true
end

SViewEquip.Unmarshal = function(self, buffer)
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

return SViewEquip

