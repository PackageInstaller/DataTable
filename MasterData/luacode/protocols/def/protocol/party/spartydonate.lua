local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPartyDonate = dataclass("SPartyDonate", require("framework.net.protocol"))
SPartyDonate.ProtocolType = 5032
SPartyDonate.MaxSize = 65535
SPartyDonate.partyId = 0
SPartyDonate.process = 0
SPartyDonate.partyCoin = 0
SPartyDonate.partyExp = 0

function SPartyDonate:Ctor(client)
  SPartyDonate.super.Ctor(self, client)
end

function SPartyDonate:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.process) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.partyCoin) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.partyExp) then
    return false
  end
  return true
end

function SPartyDonate:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.process = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.partyCoin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.partyExp = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SPartyDonate
