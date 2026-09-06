local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CLeaveParty = dataclass("CLeaveParty", require("framework.net.protocol"))
CLeaveParty.ProtocolType = 5017
CLeaveParty.MaxSize = 65535
CLeaveParty.partyId = 0

function CLeaveParty:Ctor(client)
  CLeaveParty.super.Ctor(self, client)
end

function CLeaveParty:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  return true
end

function CLeaveParty:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLeaveParty
