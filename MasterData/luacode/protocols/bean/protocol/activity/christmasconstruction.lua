local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ChristmasConstruction = dataclass("ChristmasConstruction")
ChristmasConstruction.ID = 0
ChristmasConstruction.doorID = 0

function ChristmasConstruction:Ctor()
  self.event = {}
  self.locked = {}
  self.autoExplore = {}
end

function ChristmasConstruction:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.doorID) then
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
  return true
end

function ChristmasConstruction:Unmarshal(buffer)
  local ret = true
  ret, self.ID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.doorID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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
  return ret
end

return ChristmasConstruction
