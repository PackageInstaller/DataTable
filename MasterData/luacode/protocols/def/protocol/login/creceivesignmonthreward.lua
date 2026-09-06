local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSignMonthReward = dataclass("CReceiveSignMonthReward", require("framework.net.protocol"))
CReceiveSignMonthReward.ProtocolType = 1092
CReceiveSignMonthReward.MaxSize = 65535
CReceiveSignMonthReward.signNum = 0

function CReceiveSignMonthReward:Ctor(client)
  CReceiveSignMonthReward.super.Ctor(self, client)
end

function CReceiveSignMonthReward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.signNum) then
    return false
  end
  return true
end

function CReceiveSignMonthReward:Unmarshal(buffer)
  local ret = true
  ret, self.signNum = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSignMonthReward
