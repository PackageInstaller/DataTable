local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveDonateAward = dataclass("CReceiveDonateAward", require("framework.net.protocol"))
CReceiveDonateAward.ProtocolType = 5035
CReceiveDonateAward.MaxSize = 65535
CReceiveDonateAward.partyId = 0
CReceiveDonateAward.awardId = 0

function CReceiveDonateAward:Ctor(client)
  CReceiveDonateAward.super.Ctor(self, client)
end

function CReceiveDonateAward:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.awardId) then
    return false
  end
  return true
end

function CReceiveDonateAward:Unmarshal(buffer)
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

return CReceiveDonateAward
