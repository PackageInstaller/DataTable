local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceivedBpAward = dataclass("CReceivedBpAward", require("framework.net.protocol"))
CReceivedBpAward.ProtocolType = 2675
CReceivedBpAward.MaxSize = 65535
CReceivedBpAward.awardId = 0

function CReceivedBpAward:Ctor(client)
  CReceivedBpAward.super.Ctor(self, client)
end

function CReceivedBpAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function CReceivedBpAward:Unmarshal(buffer)
  local ret = true
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceivedBpAward
