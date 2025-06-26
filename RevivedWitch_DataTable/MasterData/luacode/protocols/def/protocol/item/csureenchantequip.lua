-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/csureenchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSureEnchantEquip = dataclass("CSureEnchantEquip", require("framework.net.protocol"))
CSureEnchantEquip.ProtocolType = 1243
CSureEnchantEquip.MaxSize = 65535
CSureEnchantEquip.equipKey = 0
CSureEnchantEquip.kind = 0
CSureEnchantEquip.SURE = 1
CSureEnchantEquip.CANCEL = 2
CSureEnchantEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSureEnchantEquip
  ((CSureEnchantEquip.super).Ctor)(self, client)
end

CSureEnchantEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  return true
end

CSureEnchantEquip.Unmarshal = function(self, buffer)
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

return CSureEnchantEquip

