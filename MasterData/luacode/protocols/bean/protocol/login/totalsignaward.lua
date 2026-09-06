local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TotalSignAward = dataclass("TotalSignAward")
TotalSignAward.itemId = 0
TotalSignAward.num = 0
TotalSignAward.signTimes = 0

function TotalSignAward:Ctor()
end

function TotalSignAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.itemId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.signTimes) then
    return false
  end
  return true
end

function TotalSignAward:Unmarshal(buffer)
  local ret = true
  ret, self.itemId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.signTimes = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TotalSignAward
