local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SMainLineRewardRefreshed = dataclass("SMainLineRewardRefreshed", require("framework.net.protocol"))
SMainLineRewardRefreshed.ProtocolType = 1639
SMainLineRewardRefreshed.MaxSize = 65535

function SMainLineRewardRefreshed:Ctor(client)
  SMainLineRewardRefreshed.super.Ctor(self, client)
  self.mainLineRewardStates = {}
end

function SMainLineRewardRefreshed:Marshal(buffer)
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

function SMainLineRewardRefreshed:Unmarshal(buffer)
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

return SMainLineRewardRefreshed
