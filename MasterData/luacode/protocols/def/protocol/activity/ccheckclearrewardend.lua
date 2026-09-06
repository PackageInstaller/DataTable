local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckClearRewardEnd = dataclass("CCheckClearRewardEnd", require("framework.net.protocol"))
CCheckClearRewardEnd.ProtocolType = 2728
CCheckClearRewardEnd.MaxSize = 65535
CCheckClearRewardEnd.activityId = 0

function CCheckClearRewardEnd:Ctor(client)
  CCheckClearRewardEnd.super.Ctor(self, client)
end

function CCheckClearRewardEnd:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityId) then
    return false
  end
  return true
end

function CCheckClearRewardEnd:Unmarshal(buffer)
  local ret = true
  ret, self.activityId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckClearRewardEnd
