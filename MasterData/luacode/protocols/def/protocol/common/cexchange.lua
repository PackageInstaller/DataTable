local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CExchange = dataclass("CExchange", require("framework.net.protocol"))
CExchange.ProtocolType = 108
CExchange.MaxSize = 256
CExchange.secretKeyInMD5 = ""

function CExchange:Ctor(client)
  CExchange.super.Ctor(self, client)
end

function CExchange:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.secretKeyInMD5) then
    return false
  end
  return true
end

function CExchange:Unmarshal(buffer)
  local ret = true
  ret, self.secretKeyInMD5 = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CExchange
