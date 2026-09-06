local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFirstChargeGetReward = dataclass("SFirstChargeGetReward", require("framework.net.protocol"))
SFirstChargeGetReward.ProtocolType = 2769
SFirstChargeGetReward.MaxSize = 65535

function SFirstChargeGetReward:Ctor(client)
  SFirstChargeGetReward.super.Ctor(self, client)
  self.reward = require("protocols.bean.protocol.activity.firstchargeaward").Create()
end

function SFirstChargeGetReward:Marshal(buffer)
  if not self.reward:Marshal(buffer) then
    return false
  end
  return true
end

function SFirstChargeGetReward:Unmarshal(buffer)
  local ret = true
  if not self.reward:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SFirstChargeGetReward
