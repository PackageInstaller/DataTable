local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChristmasBossTimes = dataclass("SChristmasBossTimes", require("framework.net.protocol"))
SChristmasBossTimes.ProtocolType = 2587
SChristmasBossTimes.MaxSize = 65535
SChristmasBossTimes.times = 0

function SChristmasBossTimes:Ctor(client)
  SChristmasBossTimes.super.Ctor(self, client)
end

function SChristmasBossTimes:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.times) then
    return false
  end
  return true
end

function SChristmasBossTimes:Unmarshal(buffer)
  local ret = true
  ret, self.times = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasBossTimes
