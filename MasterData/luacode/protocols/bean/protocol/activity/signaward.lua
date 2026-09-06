local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SignAward = dataclass("SignAward")
SignAward.itemId = 0
SignAward.itemNum = 0
SignAward.receive = 0

function SignAward:Ctor()
end

function SignAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemNum) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receive) then
    return false
  end
  return true
end

function SignAward:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.itemNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.receive = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SignAward
