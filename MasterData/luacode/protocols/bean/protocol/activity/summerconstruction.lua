local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SummerConstruction = dataclass("SummerConstruction")
SummerConstruction.ID = 0
SummerConstruction.level = 0
SummerConstruction.vertical = 0
SummerConstruction.abscissa = 0
SummerConstruction.canlvup = 0
SummerConstruction.event2lock = 0

function SummerConstruction:Ctor()
  self.event = {}
  self.locked = {}
  self.autoExplore = {}
end

function SummerConstruction:Marshal(buffer)
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
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canlvup) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.event2lock) then
    return false
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
  return true
end

function SummerConstruction:Unmarshal(buffer)
  local ret = true
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
  ret, self.canlvup = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.event2lock = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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
  return ret
end

return SummerConstruction
