local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenChristmasSupportActivity = dataclass("SOpenChristmasSupportActivity", require("framework.net.protocol"))
SOpenChristmasSupportActivity.ProtocolType = 2563
SOpenChristmasSupportActivity.MaxSize = 65535
SOpenChristmasSupportActivity.state = 0
SOpenChristmasSupportActivity.score = 0
SOpenChristmasSupportActivity.activityLeftTime = 0
SOpenChristmasSupportActivity.supportLeftTime = 0
SOpenChristmasSupportActivity.canSupport = 0

function SOpenChristmasSupportActivity:Ctor(client)
  SOpenChristmasSupportActivity.super.Ctor(self, client)
  self.rewardIds = {}
end

function SOpenChristmasSupportActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  local length = table.slen(self.rewardIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardIds[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.activityLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.supportLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.canSupport) then
    return false
  end
  return true
end

function SOpenChristmasSupportActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.rewardIds[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.activityLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.supportLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.canSupport = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenChristmasSupportActivity
