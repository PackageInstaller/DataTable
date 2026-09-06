local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGlowwormCapacityLv = dataclass("CGlowwormCapacityLv", require("framework.net.protocol"))
CGlowwormCapacityLv.ProtocolType = 2340
CGlowwormCapacityLv.MaxSize = 65535

function CGlowwormCapacityLv:Ctor(client)
  CGlowwormCapacityLv.super.Ctor(self, client)
end

function CGlowwormCapacityLv:Marshal(buffer)
  return true
end

function CGlowwormCapacityLv:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGlowwormCapacityLv
