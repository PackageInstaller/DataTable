local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CEnterMainCity = dataclass("CEnterMainCity", require("framework.net.protocol"))
CEnterMainCity.ProtocolType = 1952
CEnterMainCity.MaxSize = 65535
CEnterMainCity.WaitProtocol = "protocol.notify.scancelloading"
CEnterMainCity.enterCityType = 0

function CEnterMainCity:Ctor(client)
  CEnterMainCity.super.Ctor(self, client)
end

function CEnterMainCity:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.enterCityType) then
    return false
  end
  return true
end

function CEnterMainCity:Unmarshal(buffer)
  local ret = true
  ret, self.enterCityType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CEnterMainCity
