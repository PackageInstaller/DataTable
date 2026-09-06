local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local summerechoevent = dataclass("summerechoevent")
summerechoevent.construction = 0
summerechoevent.fog = 0
summerechoevent.unlockTime = 0

function summerechoevent:Ctor()
  self.events = {}
  self.autoExplore = {}
end

function summerechoevent:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.construction) then
    return false
  end
  local length = table.slen(self.events)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.events[i]) then
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

function summerechoevent:Unmarshal(buffer)
  local ret = true
  ret, self.construction = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.events[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
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

return summerechoevent
