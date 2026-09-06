local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCancelChallenge = dataclass("SCancelChallenge", require("framework.net.protocol"))
SCancelChallenge.ProtocolType = 1980
SCancelChallenge.MaxSize = 65535
SCancelChallenge.result = 0

function SCancelChallenge:Ctor(client)
  SCancelChallenge.super.Ctor(self, client)
end

function SCancelChallenge:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.result) then
    return false
  end
  return true
end

function SCancelChallenge:Unmarshal(buffer)
  local ret = true
  ret, self.result = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SCancelChallenge
