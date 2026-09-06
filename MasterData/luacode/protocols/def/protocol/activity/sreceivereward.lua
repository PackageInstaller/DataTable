local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveReward = dataclass("SReceiveReward", require("framework.net.protocol"))
SReceiveReward.ProtocolType = 2490
SReceiveReward.MaxSize = 65535

function SReceiveReward:Ctor(client)
  SReceiveReward.super.Ctor(self, client)
  self.rewardIds = {}
end

function SReceiveReward:Marshal(buffer)
  local length = table.slen(self.rewardIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.rewardIds[i]) then
      return false
    end
  end
  return true
end

function SReceiveReward:Unmarshal(buffer)
  local ret = true
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
  return ret
end

return SReceiveReward
