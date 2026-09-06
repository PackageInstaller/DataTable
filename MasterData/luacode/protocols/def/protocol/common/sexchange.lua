local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SExchange = dataclass("SExchange", require("framework.net.protocol"))
SExchange.ProtocolType = 109
SExchange.MaxSize = 256
SExchange.secretKey = ""

function SExchange:Ctor(client)
  SExchange.super.Ctor(self, client)
end

function SExchange:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.secretKey) then
    return false
  end
  return true
end

function SExchange:Unmarshal(buffer)
  local ret = true
  ret, self.secretKey = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SExchange
