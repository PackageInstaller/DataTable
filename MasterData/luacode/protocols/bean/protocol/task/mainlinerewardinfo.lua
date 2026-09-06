local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local MainLineRewardInfo = dataclass("MainLineRewardInfo")
MainLineRewardInfo.mainLineId = 0
MainLineRewardInfo.mainLineState = 0

function MainLineRewardInfo:Ctor()
end

function MainLineRewardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mainLineId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.mainLineState) then
    return false
  end
  return true
end

function MainLineRewardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.mainLineId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.mainLineState = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return MainLineRewardInfo
