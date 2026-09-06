local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckPartyInfo = dataclass("CCheckPartyInfo", require("framework.net.protocol"))
CCheckPartyInfo.ProtocolType = 5019
CCheckPartyInfo.MaxSize = 65535
CCheckPartyInfo.partyId = 0

function CCheckPartyInfo:Ctor(client)
  CCheckPartyInfo.super.Ctor(self, client)
end

function CCheckPartyInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  return true
end

function CCheckPartyInfo:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPartyInfo
