local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckPartyInfo = dataclass("SCheckPartyInfo", require("framework.net.protocol"))
SCheckPartyInfo.ProtocolType = 5020
SCheckPartyInfo.MaxSize = 65535
SCheckPartyInfo.partyDeclaration = ""

function SCheckPartyInfo:Ctor(client)
  SCheckPartyInfo.super.Ctor(self, client)
  self.partyInfo = require("protocols.bean.protocol.party.partyinfo").Create()
  self.allMember = {}
end

function SCheckPartyInfo:Marshal(buffer)
  if not self.partyInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.partyDeclaration) then
    return false
  end
  local length = table.slen(self.allMember)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.allMember[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCheckPartyInfo:Unmarshal(buffer)
  local ret = true
  if not self.partyInfo:Unmarshal(buffer) then
    return false
  end
  ret, self.partyDeclaration = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.allMember[i] = require("protocols.bean.protocol.party.memberinfo").Create()
    if not self.allMember[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCheckPartyInfo
