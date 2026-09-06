local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local BagTypes = dataclass("BagTypes")
BagTypes.BAG = 1
BagTypes.EQUIPBAG = 4
BagTypes.VALUABLEBAG = 5
BagTypes.FURNITURE_BAG = 6

function BagTypes:Ctor()
end

function BagTypes:Marshal(buffer)
  return true
end

function BagTypes:Unmarshal(buffer)
  local ret = true
  return ret
end

return BagTypes
