local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLightPartyRedpoint = dataclass("SLightPartyRedpoint", require("framework.net.protocol"))
SLightPartyRedpoint.ProtocolType = 5030
SLightPartyRedpoint.MaxSize = 65535
SLightPartyRedpoint.PARTY = 1
SLightPartyRedpoint.PARTY_DONATE = 2
SLightPartyRedpoint.CAN_ENTER_PARTY = 3
SLightPartyRedpoint.PARTY_APPLY = 4

function SLightPartyRedpoint:Ctor(client)
  SLightPartyRedpoint.super.Ctor(self, client)
  self.redpointType = {}
end

function SLightPartyRedpoint:Marshal(buffer)
  local length = table.slen(self.redpointType)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redpointType[i]) then
      return false
    end
  end
  return true
end

function SLightPartyRedpoint:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.redpointType[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLightPartyRedpoint
