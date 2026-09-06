local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SChristmasSupportShopState = dataclass("SChristmasSupportShopState", require("framework.net.protocol"))
SChristmasSupportShopState.ProtocolType = 2571
SChristmasSupportShopState.MaxSize = 65535
SChristmasSupportShopState.state = 0

function SChristmasSupportShopState:Ctor(client)
  SChristmasSupportShopState.super.Ctor(self, client)
end

function SChristmasSupportShopState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SChristmasSupportShopState:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SChristmasSupportShopState
