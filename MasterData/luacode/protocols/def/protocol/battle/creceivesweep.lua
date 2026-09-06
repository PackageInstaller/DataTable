local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveSweep = dataclass("CReceiveSweep", require("framework.net.protocol"))
CReceiveSweep.ProtocolType = 4137
CReceiveSweep.MaxSize = 65535

function CReceiveSweep:Ctor(client)
  CReceiveSweep.super.Ctor(self, client)
end

function CReceiveSweep:Marshal(buffer)
  return true
end

function CReceiveSweep:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReceiveSweep
