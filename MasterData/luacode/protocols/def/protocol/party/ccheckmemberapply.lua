local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckMemberApply = dataclass("CCheckMemberApply", require("framework.net.protocol"))
CCheckMemberApply.ProtocolType = 5010
CCheckMemberApply.MaxSize = 65535
CCheckMemberApply.partyId = 0

function CCheckMemberApply:Ctor(client)
  CCheckMemberApply.super.Ctor(self, client)
end

function CCheckMemberApply:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  return true
end

function CCheckMemberApply:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckMemberApply
