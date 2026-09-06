local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SShowPartyDonateProcess = dataclass("SShowPartyDonateProcess", require("framework.net.protocol"))
SShowPartyDonateProcess.ProtocolType = 5034
SShowPartyDonateProcess.MaxSize = 65535
SShowPartyDonateProcess.partyId = 0
SShowPartyDonateProcess.process = 0
SShowPartyDonateProcess.partyCoin = 0

function SShowPartyDonateProcess:Ctor(client)
  SShowPartyDonateProcess.super.Ctor(self, client)
  self.receiveAwards = {}
end

function SShowPartyDonateProcess:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.process) then
    return false
  end
  local length = table.slen(self.receiveAwards)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.receiveAwards[i]) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.partyCoin) then
    return false
  end
  return true
end

function SShowPartyDonateProcess:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.process = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.receiveAwards[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  ret, self.partyCoin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SShowPartyDonateProcess
