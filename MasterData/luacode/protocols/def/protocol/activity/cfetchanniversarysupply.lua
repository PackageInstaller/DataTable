local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFetchAnniversarySupply = dataclass("CFetchAnniversarySupply", require("framework.net.protocol"))
CFetchAnniversarySupply.ProtocolType = 2681
CFetchAnniversarySupply.MaxSize = 65535
CFetchAnniversarySupply.supply = 0

function CFetchAnniversarySupply:Ctor(client)
  CFetchAnniversarySupply.super.Ctor(self, client)
end

function CFetchAnniversarySupply:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.supply) then
    return false
  end
  return true
end

function CFetchAnniversarySupply:Unmarshal(buffer)
  local ret = true
  ret, self.supply = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchAnniversarySupply
