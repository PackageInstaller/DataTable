local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetShatteredZonesInfo = dataclass("CGetShatteredZonesInfo", require("framework.net.protocol"))
CGetShatteredZonesInfo.ProtocolType = 2410
CGetShatteredZonesInfo.MaxSize = 65535

function CGetShatteredZonesInfo:Ctor(client)
  CGetShatteredZonesInfo.super.Ctor(self, client)
end

function CGetShatteredZonesInfo:Marshal(buffer)
  return true
end

function CGetShatteredZonesInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetShatteredZonesInfo
