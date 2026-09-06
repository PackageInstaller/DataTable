local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Furniture = dataclass("Furniture")
Furniture.key = 0
Furniture.itemId = 0

function Furniture:Ctor()
  self.point = require("protocols.bean.protocol.yard.point").Create()
end

function Furniture:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not self.point:Marshal(buffer) then
    return false
  end
  return true
end

function Furniture:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.point:Unmarshal(buffer) then
    return false
  end
  return ret
end

return Furniture
