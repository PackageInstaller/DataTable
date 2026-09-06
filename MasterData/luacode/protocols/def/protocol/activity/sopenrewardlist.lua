local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenRewardList = dataclass("SOpenRewardList", require("framework.net.protocol"))
SOpenRewardList.ProtocolType = 2488
SOpenRewardList.MaxSize = 65535
SOpenRewardList.maxContinueId = 0
SOpenRewardList.score = 0
SOpenRewardList.endTime = 0

function SOpenRewardList:Ctor(client)
  SOpenRewardList.super.Ctor(self, client)
  self.receiveAward = {}
end

function SOpenRewardList:Marshal(buffer)
  local length = table.slen(self.receiveAward)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receiveAward[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.maxContinueId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.score) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.endTime) then
    return false
  end
  return true
end

function SOpenRewardList:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receiveAward[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.maxContinueId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.score = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.endTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenRewardList
