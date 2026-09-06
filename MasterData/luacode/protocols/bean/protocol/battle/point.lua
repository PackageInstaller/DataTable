local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Point = dataclass("Point")
Point.x = 0
Point.y = 0
Point.dir = 0

function Point:Ctor()
end

function Point:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.x) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.y) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dir) then
    return false
  end
  return true
end

function Point:Unmarshal(buffer)
  local ret = true
  ret, self.x = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.y = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.dir = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Point
