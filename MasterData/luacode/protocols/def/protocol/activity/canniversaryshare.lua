local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAnniversaryShare = dataclass("CAnniversaryShare", require("framework.net.protocol"))
CAnniversaryShare.ProtocolType = 2694
CAnniversaryShare.MaxSize = 65535

function CAnniversaryShare:Ctor(client)
  CAnniversaryShare.super.Ctor(self, client)
end

function CAnniversaryShare:Marshal(buffer)
  return true
end

function CAnniversaryShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return CAnniversaryShare
