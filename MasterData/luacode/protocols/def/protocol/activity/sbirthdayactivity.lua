local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBirthdayActivity = dataclass("SBirthdayActivity", require("framework.net.protocol"))
SBirthdayActivity.ProtocolType = 2542
SBirthdayActivity.MaxSize = 65535
SBirthdayActivity.state = 0
SBirthdayActivity.startDay = 0
SBirthdayActivity.endDay = 0
SBirthdayActivity.share = 0
SBirthdayActivity.wish = 0
SBirthdayActivity.maxMissionId = 0
SBirthdayActivity.extraItemLeftTime = 0

function SBirthdayActivity:Ctor(client)
  SBirthdayActivity.super.Ctor(self, client)
  self.rewardRecord = {}
end

function SBirthdayActivity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.startDay) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endDay) then
    return false
  end
  local length = table.slen(self.rewardRecord)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardRecord[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.share) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.wish) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxMissionId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.extraItemLeftTime) then
    return false
  end
  return true
end

function SBirthdayActivity:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.startDay = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.endDay = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.rewardRecord[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.share = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.wish = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.maxMissionId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.extraItemLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SBirthdayActivity
