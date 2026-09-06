local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CMoveSummerConstruction = dataclass("CMoveSummerConstruction", require("framework.net.protocol"))
CMoveSummerConstruction.ProtocolType = 2475
CMoveSummerConstruction.MaxSize = 65535
CMoveSummerConstruction.construction = 0
CMoveSummerConstruction.vertical = 0
CMoveSummerConstruction.abscissa = 0
CMoveSummerConstruction.RECLAIM = 999

function CMoveSummerConstruction:Ctor(client)
  CMoveSummerConstruction.super.Ctor(self, client)
end

function CMoveSummerConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.construction) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.vertical) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.abscissa) then
    return false
  end
  return true
end

function CMoveSummerConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.construction = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.vertical = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.abscissa = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CMoveSummerConstruction
