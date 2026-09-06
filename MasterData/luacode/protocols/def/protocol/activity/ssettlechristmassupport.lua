local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSettleChristmasSupport = dataclass("SSettleChristmasSupport", require("framework.net.protocol"))
SSettleChristmasSupport.ProtocolType = 2570
SSettleChristmasSupport.MaxSize = 65535
SSettleChristmasSupport.state = 0
SSettleChristmasSupport.settle = 0

function SSettleChristmasSupport:Ctor(client)
  SSettleChristmasSupport.super.Ctor(self, client)
end

function SSettleChristmasSupport:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.settle) then
    return false
  end
  return true
end

function SSettleChristmasSupport:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.settle = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSettleChristmasSupport
