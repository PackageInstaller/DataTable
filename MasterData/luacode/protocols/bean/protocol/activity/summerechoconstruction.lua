local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SummerEchoConstruction = dataclass("SummerEchoConstruction")
SummerEchoConstruction.ID = 0
SummerEchoConstruction.vertical = 0
SummerEchoConstruction.abscissa = 0
SummerEchoConstruction.fog = 0
SummerEchoConstruction.unlockTime = 0

function SummerEchoConstruction:Ctor()
  self.event = {}
  self.locked = {}
  self.autoExplore = {}
end

function SummerEchoConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ID) then
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
  local length = table.slen(self.locked)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.locked[i]) then
      return false
    end
  end
  local length = table.slen(self.autoExplore)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoExplore[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.fog) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.unlockTime) then
    return false
  end
  return true
end

function SummerEchoConstruction:Unmarshal(buffer)
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.locked[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.autoExplore[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.fog = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.unlockTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SummerEchoConstruction
