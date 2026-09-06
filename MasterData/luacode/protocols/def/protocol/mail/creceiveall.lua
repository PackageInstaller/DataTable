local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveAll = dataclass("CReceiveAll", require("framework.net.protocol"))
CReceiveAll.ProtocolType = 1407
CReceiveAll.MaxSize = 65535

function CReceiveAll:Ctor(client)
  CReceiveAll.super.Ctor(self, client)
end

function CReceiveAll:Marshal(buffer)
  return true
end

function CReceiveAll:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReceiveAll
