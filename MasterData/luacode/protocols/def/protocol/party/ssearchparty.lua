local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSearchParty = dataclass("SSearchParty", require("framework.net.protocol"))
SSearchParty.ProtocolType = 5002
SSearchParty.MaxSize = 65535

function SSearchParty:Ctor(client)
  SSearchParty.super.Ctor(self, client)
  self.allParty = {}
end

function SSearchParty:Marshal(buffer)
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

function SSearchParty:Unmarshal(buffer)
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

return SSearchParty
