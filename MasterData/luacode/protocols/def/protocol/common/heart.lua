local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local Heart = dataclass("Heart", require("framework.net.protocol"))
Heart.ProtocolType = 100
Heart.MaxSize = 256

function Heart:Ctor(client)
  Heart.super.Ctor(self, client)
end

function Heart:Marshal(buffer)
  return true
end

function Heart:Unmarshal(buffer)
  local ret = true
  return ret
end

return Heart
