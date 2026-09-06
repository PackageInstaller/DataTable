local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local battlebuff = dataclass("battlebuff")
battlebuff.id = 0
battlebuff.num = 0
battlebuff.roleLimit = ""

function battlebuff:Ctor()
end

function battlebuff:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.roleLimit) then
    return false
  end
  return true
end

function battlebuff:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.roleLimit = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return battlebuff
