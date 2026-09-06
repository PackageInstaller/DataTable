local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUpdateSummerConstruction = dataclass("CUpdateSummerConstruction", require("framework.net.protocol"))
CUpdateSummerConstruction.ProtocolType = 2471
CUpdateSummerConstruction.MaxSize = 65535
CUpdateSummerConstruction.ID = 0
CUpdateSummerConstruction.vertical = 0
CUpdateSummerConstruction.abscissa = 0

function CUpdateSummerConstruction:Ctor(client)
  CUpdateSummerConstruction.super.Ctor(self, client)
end

function CUpdateSummerConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ID) then
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

function CUpdateSummerConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.ID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return CUpdateSummerConstruction
