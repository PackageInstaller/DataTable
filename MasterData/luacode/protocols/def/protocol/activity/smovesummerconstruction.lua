local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMoveSummerConstruction = dataclass("SMoveSummerConstruction", require("framework.net.protocol"))
SMoveSummerConstruction.ProtocolType = 2476
SMoveSummerConstruction.MaxSize = 65535
SMoveSummerConstruction.result = 0
SMoveSummerConstruction.ID = 0
SMoveSummerConstruction.level = 0
SMoveSummerConstruction.vertical = 0
SMoveSummerConstruction.abscissa = 0

function SMoveSummerConstruction:Ctor(client)
  SMoveSummerConstruction.super.Ctor(self, client)
  self.event = {}
end

function SMoveSummerConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.level) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.vertical) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.abscissa) then
    return false
  end
  local length = table.slen(self.event)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.event[i]) then
      return false
    end
  end
  return true
end

function SMoveSummerConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.ID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.level = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.event[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SMoveSummerConstruction
