local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRequestPartyRank = dataclass("SRequestPartyRank", require("framework.net.protocol"))
SRequestPartyRank.ProtocolType = 5039
SRequestPartyRank.MaxSize = 65535

function SRequestPartyRank:Ctor(client)
  SRequestPartyRank.super.Ctor(self, client)
  self.allParty = {}
end

function SRequestPartyRank:Marshal(buffer)
  local length = table.slen(self.allParty)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.allParty[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRequestPartyRank:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.allParty[i] = require("protocols.bean.protocol.party.partyinfo").Create()
    if not self.allParty[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRequestPartyRank
