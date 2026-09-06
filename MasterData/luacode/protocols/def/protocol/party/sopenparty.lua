local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SOpenParty = dataclass("SOpenParty", require("framework.net.protocol"))
SOpenParty.ProtocolType = 5006
SOpenParty.MaxSize = 65535
SOpenParty.partyDeclaration = ""
SOpenParty.position = 0
SOpenParty.hesitationPeriod = 0
SOpenParty.firstEnter = 0
SOpenParty.crossdayInterval = 0

function SOpenParty:Ctor(client)
  SOpenParty.super.Ctor(self, client)
  self.partyInfo = require("protocols.bean.protocol.party.partyinfo").Create()
end

function SOpenParty:Marshal(buffer)
  if not self.partyInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyDeclaration) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.position) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.hesitationPeriod) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.firstEnter) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.crossdayInterval) then
    return false
  end
  return true
end

function SOpenParty:Unmarshal(buffer)
  local ret = true
  if not self.partyInfo:Unmarshal(buffer) then
    return false
  end
  ret, self.partyDeclaration = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.position = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.hesitationPeriod = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.firstEnter = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.crossdayInterval = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SOpenParty
