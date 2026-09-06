local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCheckGainNumber = dataclass("CCheckGainNumber", require("framework.net.protocol"))
CCheckGainNumber.ProtocolType = 2606
CCheckGainNumber.MaxSize = 65535

function CCheckGainNumber:Ctor(client)
  CCheckGainNumber.super.Ctor(self, client)
end

function CCheckGainNumber:Marshal(buffer)
  return true
end

function CCheckGainNumber:Unmarshal(buffer)
  local ret = true
  return ret
end

return CCheckGainNumber
