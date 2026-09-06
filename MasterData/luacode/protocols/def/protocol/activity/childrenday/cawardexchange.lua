local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAwardExchange = dataclass("CAwardExchange", require("framework.net.protocol"))
CAwardExchange.ProtocolType = 2652
CAwardExchange.MaxSize = 65535
CAwardExchange.node = 0

function CAwardExchange:Ctor(client)
  CAwardExchange.super.Ctor(self, client)
end

function CAwardExchange:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.node) then
    return false
  end
  return true
end

function CAwardExchange:Unmarshal(buffer)
  local ret = true
  ret, self.node = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAwardExchange
