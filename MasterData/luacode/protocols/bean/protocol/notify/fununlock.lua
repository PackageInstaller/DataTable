local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local FunUnlock = dataclass("FunUnlock")
FunUnlock.funId = 0
FunUnlock.sortId = 0

function FunUnlock:Ctor()
end

function FunUnlock:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.funId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.sortId) then
    return false
  end
  return true
end

function FunUnlock:Unmarshal(buffer)
  local ret = true
  ret, self.funId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.sortId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return FunUnlock
