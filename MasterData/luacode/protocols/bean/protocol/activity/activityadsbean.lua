local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local ActivityAdsBean = dataclass("ActivityAdsBean")
ActivityAdsBean.id = 0
ActivityAdsBean.leftActiveTime = 0
ActivityAdsBean.ifJumpActive = 0
ActivityAdsBean.leftStartTime = 0

function ActivityAdsBean:Ctor()
end

function ActivityAdsBean:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.id) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftActiveTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.ifJumpActive) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftStartTime) then
    return false
  end
  return true
end

function ActivityAdsBean:Unmarshal(buffer)
  local ret = true
  ret, self.id = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftActiveTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.ifJumpActive = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.leftStartTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ActivityAdsBean
