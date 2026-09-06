local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceivedBpAward = dataclass("SReceivedBpAward", require("framework.net.protocol"))
SReceivedBpAward.ProtocolType = 2676
SReceivedBpAward.MaxSize = 65535
SReceivedBpAward.awardId = 0

function SReceivedBpAward:Ctor(client)
  SReceivedBpAward.super.Ctor(self, client)
end

function SReceivedBpAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function SReceivedBpAward:Unmarshal(buffer)
  local ret = true
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceivedBpAward
