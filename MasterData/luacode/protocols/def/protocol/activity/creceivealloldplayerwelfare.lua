local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveAllOldPlayerWelfare = dataclass("CReceiveAllOldPlayerWelfare", require("framework.net.protocol"))
CReceiveAllOldPlayerWelfare.ProtocolType = 2736
CReceiveAllOldPlayerWelfare.MaxSize = 65535

function CReceiveAllOldPlayerWelfare:Ctor(client)
  CReceiveAllOldPlayerWelfare.super.Ctor(self, client)
end

function CReceiveAllOldPlayerWelfare:Marshal(buffer)
  return true
end

function CReceiveAllOldPlayerWelfare:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReceiveAllOldPlayerWelfare
