-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/spreenchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SPreEnchantEquip = dataclass("SPreEnchantEquip", require("framework.net.protocol"))
SPreEnchantEquip.ProtocolType = 1244
SPreEnchantEquip.MaxSize = 65535
SPreEnchantEquip.equipKey = 0
SPreEnchantEquip.leftEnchant = 0
SPreEnchantEquip.stuff = 0
SPreEnchantEquip.luck = 0
SPreEnchantEquip.nextCostMaNa = 0
SPreEnchantEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SPreEnchantEquip, _ENV
  ((SPreEnchantEquip.super).Ctor)(self, client)
  self.entries = {}
  self.finalAttr = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
end

SPreEnchantEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftEnchant) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stuff) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.luck) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nextCostMaNa) then
    return false
  end
  local length = (table.slen)(self.entries)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.entries)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.finalAttr):Marshal(buffer) then
    return false
  end
  return true
end

SPreEnchantEquip.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    (self.entries)[i] = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
    if not ((self.entries)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.finalAttr):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SPreEnchantEquip

