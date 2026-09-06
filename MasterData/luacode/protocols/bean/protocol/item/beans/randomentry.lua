local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local RandomEntry = dataclass("RandomEntry")
RandomEntry.index = 0
RandomEntry.randomId = 0
RandomEntry.kind = 0
RandomEntry.attr = 0
RandomEntry.attrValue = 0
RandomEntry.skill = 0

function RandomEntry:Ctor()
end

function RandomEntry:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.index) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.randomId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.kind) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.attr) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.attrValue) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.skill) then
    return false
  end
  return true
end

function RandomEntry:Unmarshal(buffer)
  local ret = true
  ret, self.index = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.randomId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.kind = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.attr = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.attrValue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.skill = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return RandomEntry
