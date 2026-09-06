local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAnniversaryShareInfo = dataclass("SAnniversaryShareInfo", require("framework.net.protocol"))
SAnniversaryShareInfo.ProtocolType = 2693
SAnniversaryShareInfo.MaxSize = 65535
SAnniversaryShareInfo.leftTime = 0
SAnniversaryShareInfo.shareLeftTime = 0
SAnniversaryShareInfo.picture = 0
SAnniversaryShareInfo.totalShare = 0
SAnniversaryShareInfo.dailyShareAward = 0
SAnniversaryShareInfo.LOCKED = 0
SAnniversaryShareInfo.UNLOCKED = 1
SAnniversaryShareInfo.FETCHED = 2

function SAnniversaryShareInfo:Ctor(client)
  SAnniversaryShareInfo.super.Ctor(self, client)
  self.totShareAward = {}
end

function SAnniversaryShareInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.leftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.shareLeftTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.picture) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.totalShare) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.totShareAward)) then
    return false
  end
  for key, value in pairs(self.totShareAward) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dailyShareAward) then
    return false
  end
  return true
end

function SAnniversaryShareInfo:Unmarshal(buffer)
  local ret = true
  ret, self.leftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.shareLeftTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.picture = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalShare = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.totShareAward[key] = value
  end
  ret, self.dailyShareAward = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAnniversaryShareInfo
