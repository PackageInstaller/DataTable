local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local EquipType = dataclass("EquipType")
EquipType.WEAPON = 299
EquipType.JEWELRY = 555
EquipType.ARMOR = 811

function EquipType:Ctor()
end

function EquipType:Marshal(buffer)
  return true
end

function EquipType:Unmarshal(buffer)
  local ret = true
  return ret
end

return EquipType
