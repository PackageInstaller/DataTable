local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SNeed2RenewShatteredZones = dataclass("SNeed2RenewShatteredZones", require("framework.net.protocol"))
SNeed2RenewShatteredZones.ProtocolType = 2412
SNeed2RenewShatteredZones.MaxSize = 65535

function SNeed2RenewShatteredZones:Ctor(client)
  SNeed2RenewShatteredZones.super.Ctor(self, client)
end

function SNeed2RenewShatteredZones:Marshal(buffer)
  return true
end

function SNeed2RenewShatteredZones:Unmarshal(buffer)
  local ret = true
  return ret
end

return SNeed2RenewShatteredZones
