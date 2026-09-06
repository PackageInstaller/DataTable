local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenTotalSupportScore = dataclass("COpenTotalSupportScore", require("framework.net.protocol"))
COpenTotalSupportScore.ProtocolType = 2568
COpenTotalSupportScore.MaxSize = 65535

function COpenTotalSupportScore:Ctor(client)
  COpenTotalSupportScore.super.Ctor(self, client)
end

function COpenTotalSupportScore:Marshal(buffer)
  return true
end

function COpenTotalSupportScore:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenTotalSupportScore
