local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMainLineReward = dataclass("SMainLineReward", require("framework.net.protocol"))
SMainLineReward.ProtocolType = 1636
SMainLineReward.MaxSize = 65535

function SMainLineReward:Ctor(client)
  SMainLineReward.super.Ctor(self, client)
  self.mainLineRewardStates = {}
end

function SMainLineReward:Marshal(buffer)
  local length = table.slen(self.mainLineRewardStates)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.mainLineRewardStates[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SMainLineReward:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.mainLineRewardStates[i] = require("protocols.bean.protocol.task.mainlinerewardinfo").Create()
    if not self.mainLineRewardStates[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SMainLineReward
