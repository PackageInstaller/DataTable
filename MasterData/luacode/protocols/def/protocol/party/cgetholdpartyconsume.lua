local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetHoldPartyConsume = dataclass("CGetHoldPartyConsume", require("framework.net.protocol"))
CGetHoldPartyConsume.ProtocolType = 5027
CGetHoldPartyConsume.MaxSize = 65535

function CGetHoldPartyConsume:Ctor(client)
  CGetHoldPartyConsume.super.Ctor(self, client)
end

function CGetHoldPartyConsume:Marshal(buffer)
  return true
end

function CGetHoldPartyConsume:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetHoldPartyConsume
