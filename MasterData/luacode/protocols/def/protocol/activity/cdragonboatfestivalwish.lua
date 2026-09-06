local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDragonBoatFestivalWish = dataclass("CDragonBoatFestivalWish", require("framework.net.protocol"))
CDragonBoatFestivalWish.ProtocolType = 2654
CDragonBoatFestivalWish.MaxSize = 65535

function CDragonBoatFestivalWish:Ctor(client)
  CDragonBoatFestivalWish.super.Ctor(self, client)
end

function CDragonBoatFestivalWish:Marshal(buffer)
  return true
end

function CDragonBoatFestivalWish:Unmarshal(buffer)
  local ret = true
  return ret
end

return CDragonBoatFestivalWish
