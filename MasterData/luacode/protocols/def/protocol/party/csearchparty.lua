local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CSearchParty = dataclass("CSearchParty", require("framework.net.protocol"))
CSearchParty.ProtocolType = 5001
CSearchParty.MaxSize = 65535
CSearchParty.partyId = 0

function CSearchParty:Ctor(client)
  CSearchParty.super.Ctor(self, client)
  self.excludePartyIds = {}
end

function CSearchParty:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  local length = table.slen(self.excludePartyIds)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.excludePartyIds[i]) then
      return false
    end
  end
  return true
end

function CSearchParty:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.excludePartyIds[i] = ProtocolBufferStaticFunctions.ReadInt64(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CSearchParty
