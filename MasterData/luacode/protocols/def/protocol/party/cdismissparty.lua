local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDismissParty = dataclass("CDismissParty", require("framework.net.protocol"))
CDismissParty.ProtocolType = 5016
CDismissParty.MaxSize = 65535
CDismissParty.partyId = 0
CDismissParty.operate = 0

function CDismissParty:Ctor(client)
  CDismissParty.super.Ctor(self, client)
end

function CDismissParty:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.partyId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.operate) then
    return false
  end
  return true
end

function CDismissParty:Unmarshal(buffer)
  local ret = true
  ret, self.partyId = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.operate = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDismissParty
