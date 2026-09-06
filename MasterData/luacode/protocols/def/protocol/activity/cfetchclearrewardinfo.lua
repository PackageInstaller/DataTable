local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchClearRewardInfo = dataclass("CFetchClearRewardInfo", require("framework.net.protocol"))
CFetchClearRewardInfo.ProtocolType = 2727
CFetchClearRewardInfo.MaxSize = 65535
CFetchClearRewardInfo.activityId = 0

function CFetchClearRewardInfo:Ctor(client)
  CFetchClearRewardInfo.super.Ctor(self, client)
end

function CFetchClearRewardInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function CFetchClearRewardInfo:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchClearRewardInfo
