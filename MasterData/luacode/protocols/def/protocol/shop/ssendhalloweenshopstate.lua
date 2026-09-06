local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SSendHalloweenShopState = dataclass("SSendHalloweenShopState", require("framework.net.protocol"))
SSendHalloweenShopState.ProtocolType = 3644
SSendHalloweenShopState.MaxSize = 65535
SSendHalloweenShopState.state = 0
SSendHalloweenShopState.OPEN = 1
SSendHalloweenShopState.CLOSE = 0

function SSendHalloweenShopState:Ctor(client)
  SSendHalloweenShopState.super.Ctor(self, client)
end

function SSendHalloweenShopState:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.state) then
    return false
  end
  return true
end

function SSendHalloweenShopState:Unmarshal(buffer)
  local ret = true
  ret, self.state = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendHalloweenShopState
