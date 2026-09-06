local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckPartyMemberInfo = dataclass("CCheckPartyMemberInfo", require("framework.net.protocol"))
CCheckPartyMemberInfo.ProtocolType = 5008
CCheckPartyMemberInfo.MaxSize = 65535
CCheckPartyMemberInfo.partyId = 0

function CCheckPartyMemberInfo:Ctor(client)
  CCheckPartyMemberInfo.super.Ctor(self, client)
end

function CCheckPartyMemberInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  return true
end

function CCheckPartyMemberInfo:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPartyMemberInfo
