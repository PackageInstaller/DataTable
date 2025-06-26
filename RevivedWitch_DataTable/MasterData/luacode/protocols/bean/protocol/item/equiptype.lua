-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/item/equiptype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local EquipType = dataclass("EquipType")
EquipType.WEAPON = 299
EquipType.JEWELRY = 555
EquipType.ARMOR = 811
EquipType.Ctor = function(self)
  -- function num : 0_0
end

EquipType.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

EquipType.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return EquipType

