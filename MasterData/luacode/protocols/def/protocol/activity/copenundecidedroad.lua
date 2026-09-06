local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenUndecidedRoad = dataclass("COpenUndecidedRoad", require("framework.net.protocol"))
COpenUndecidedRoad.ProtocolType = 2479
COpenUndecidedRoad.MaxSize = 65535

function COpenUndecidedRoad:Ctor(client)
  COpenUndecidedRoad.super.Ctor(self, client)
end

function COpenUndecidedRoad:Marshal(buffer)
  return true
end

function COpenUndecidedRoad:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenUndecidedRoad
