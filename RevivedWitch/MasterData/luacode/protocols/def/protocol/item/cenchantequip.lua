-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/cenchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CEnchantEquip = dataclass("CEnchantEquip", require("framework.net.protocol"))
CEnchantEquip.ProtocolType = 1216
CEnchantEquip.MaxSize = 65535
CEnchantEquip.equipKey = 0
CEnchantEquip.stuff = 0
CEnchantEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CEnchantEquip
  ((CEnchantEquip.super).Ctor)(self, client)
end

CEnchantEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stuff) then
    return false
  end
  return true
end

CEnchantEquip.Unmarshal = function(self, buffer)
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

return CEnchantEquip

