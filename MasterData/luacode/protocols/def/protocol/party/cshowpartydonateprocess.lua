local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CShowPartyDonateProcess = dataclass("CShowPartyDonateProcess", require("framework.net.protocol"))
CShowPartyDonateProcess.ProtocolType = 5033
CShowPartyDonateProcess.MaxSize = 65535

function CShowPartyDonateProcess:Ctor(client)
  CShowPartyDonateProcess.super.Ctor(self, client)
end

function CShowPartyDonateProcess:Marshal(buffer)
  return true
end

function CShowPartyDonateProcess:Unmarshal(buffer)
  local ret = true
  return ret
end

return CShowPartyDonateProcess
