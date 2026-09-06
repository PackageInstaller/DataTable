local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SReceiveDonateAward = dataclass("SReceiveDonateAward", require("framework.net.protocol"))
SReceiveDonateAward.ProtocolType = 5036
SReceiveDonateAward.MaxSize = 65535
SReceiveDonateAward.partyId = 0
SReceiveDonateAward.awardId = 0

function SReceiveDonateAward:Ctor(client)
  SReceiveDonateAward.super.Ctor(self, client)
end

function SReceiveDonateAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function SReceiveDonateAward:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.awardId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveDonateAward
