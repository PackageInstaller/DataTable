local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SUseGiftKey = dataclass("SUseGiftKey", require("framework.net.protocol"))
SUseGiftKey.ProtocolType = 1253
SUseGiftKey.MaxSize = 65535

function SUseGiftKey:Ctor(client)
  SUseGiftKey.super.Ctor(self, client)
end

function SUseGiftKey:Marshal(buffer)
  return true
end

function SUseGiftKey:Unmarshal(buffer)
  local ret = true
  return ret
end

return SUseGiftKey
