local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnterNextFloor = dataclass("CEnterNextFloor", require("framework.net.protocol"))
CEnterNextFloor.ProtocolType = 2624
CEnterNextFloor.MaxSize = 65535

function CEnterNextFloor:Ctor(client)
  CEnterNextFloor.super.Ctor(self, client)
end

function CEnterNextFloor:Marshal(buffer)
  return true
end

function CEnterNextFloor:Unmarshal(buffer)
  local ret = true
  return ret
end

return CEnterNextFloor
