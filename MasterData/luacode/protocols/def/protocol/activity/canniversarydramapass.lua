local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAnniversaryDramaPass = dataclass("CAnniversaryDramaPass", require("framework.net.protocol"))
CAnniversaryDramaPass.ProtocolType = 2684
CAnniversaryDramaPass.MaxSize = 65535

function CAnniversaryDramaPass:Ctor(client)
  CAnniversaryDramaPass.super.Ctor(self, client)
end

function CAnniversaryDramaPass:Marshal(buffer)
  return true
end

function CAnniversaryDramaPass:Unmarshal(buffer)
  local ret = true
  return ret
end

return CAnniversaryDramaPass
