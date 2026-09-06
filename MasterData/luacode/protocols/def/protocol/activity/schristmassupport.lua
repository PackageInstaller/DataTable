local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChristmasSupport = dataclass("SChristmasSupport", require("framework.net.protocol"))
SChristmasSupport.ProtocolType = 2565
SChristmasSupport.MaxSize = 65535
SChristmasSupport.num = 0
SChristmasSupport.addScore = 0

function SChristmasSupport:Ctor(client)
  SChristmasSupport.super.Ctor(self, client)
end

function SChristmasSupport:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.addScore) then
    return false
  end
  return true
end

function SChristmasSupport:Unmarshal(buffer)
  local ret = true
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.addScore = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasSupport
