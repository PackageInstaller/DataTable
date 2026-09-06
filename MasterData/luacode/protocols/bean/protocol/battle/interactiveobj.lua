local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local InterActiveObj = dataclass("InterActiveObj")
InterActiveObj.id = 0
InterActiveObj.state = 0
InterActiveObj.NO_SHOW = 1
InterActiveObj.SHOW = 2
InterActiveObj.INTERACTIVE = 3

function InterActiveObj:Ctor()
end

function InterActiveObj:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function InterActiveObj:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return InterActiveObj
