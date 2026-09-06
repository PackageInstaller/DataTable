local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CHoldParty = dataclass("CHoldParty", require("framework.net.protocol"))
CHoldParty.ProtocolType = 5003
CHoldParty.MaxSize = 65535
CHoldParty.partyName = ""
CHoldParty.partyDeclaration = ""
CHoldParty.autoAcceptApply = 0
CHoldParty.avatarId = 0

function CHoldParty:Ctor(client)
  CHoldParty.super.Ctor(self, client)
end

function CHoldParty:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyName) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyDeclaration) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.autoAcceptApply) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.avatarId) then
    return false
  end
  return true
end

function CHoldParty:Unmarshal(buffer)
  local ret = true
  ret, self.partyName = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.partyDeclaration = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  ret, self.autoAcceptApply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.avatarId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CHoldParty
