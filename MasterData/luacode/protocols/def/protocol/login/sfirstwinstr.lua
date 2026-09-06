local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SFirstWinSTR = dataclass("SFirstWinSTR", require("framework.net.protocol"))
SFirstWinSTR.ProtocolType = 1074
SFirstWinSTR.MaxSize = 65535

function SFirstWinSTR:Ctor(client)
  SFirstWinSTR.super.Ctor(self, client)
end

function SFirstWinSTR:Marshal(buffer)
  return true
end

function SFirstWinSTR:Unmarshal(buffer)
  local ret = true
  return ret
end

return SFirstWinSTR
