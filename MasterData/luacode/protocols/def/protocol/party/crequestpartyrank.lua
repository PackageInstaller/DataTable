local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CRequestPartyRank = dataclass("CRequestPartyRank", require("framework.net.protocol"))
CRequestPartyRank.ProtocolType = 5038
CRequestPartyRank.MaxSize = 65535

function CRequestPartyRank:Ctor(client)
  CRequestPartyRank.super.Ctor(self, client)
end

function CRequestPartyRank:Marshal(buffer)
  return true
end

function CRequestPartyRank:Unmarshal(buffer)
  local ret = true
  return ret
end

return CRequestPartyRank
