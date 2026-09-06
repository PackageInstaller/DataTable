local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CInterruptSweep = dataclass("CInterruptSweep", require("framework.net.protocol"))
CInterruptSweep.ProtocolType = 4138
CInterruptSweep.MaxSize = 65535

function CInterruptSweep:Ctor(client)
  CInterruptSweep.super.Ctor(self, client)
end

function CInterruptSweep:Marshal(buffer)
  return true
end

function CInterruptSweep:Unmarshal(buffer)
  local ret = true
  return ret
end

return CInterruptSweep
