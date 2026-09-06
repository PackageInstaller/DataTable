local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCancelChallenge = dataclass("CCancelChallenge", require("framework.net.protocol"))
CCancelChallenge.ProtocolType = 1979
CCancelChallenge.MaxSize = 65535
CCancelChallenge.cancelTower = 0

function CCancelChallenge:Ctor(client)
  CCancelChallenge.super.Ctor(self, client)
end

function CCancelChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.cancelTower) then
    return false
  end
  return true
end

function CCancelChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.cancelTower = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCancelChallenge
