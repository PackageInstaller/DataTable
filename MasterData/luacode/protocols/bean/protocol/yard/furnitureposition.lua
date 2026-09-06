local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FurniturePosition = dataclass("FurniturePosition")
FurniturePosition.itemId = 0

function FurniturePosition:Ctor()
  self.point = require("protocols.bean.protocol.yard.point").Create()
end

function FurniturePosition:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not self.point:Marshal(buffer) then
    return false
  end
  return true
end

function FurniturePosition:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.point:Unmarshal(buffer) then
    return false
  end
  return ret
end

return FurniturePosition
