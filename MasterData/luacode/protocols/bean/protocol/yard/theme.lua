local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Theme = dataclass("Theme")
Theme.key = 0
Theme.name = ""

function Theme:Ctor()
  self.furniturePositions = {}
end

function Theme:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  local length = table.slen(self.furniturePositions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.furniturePositions[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function Theme:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.furniturePositions[i] = require("protocols.bean.protocol.yard.furnitureposition").Create()
    if not self.furniturePositions[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return Theme
