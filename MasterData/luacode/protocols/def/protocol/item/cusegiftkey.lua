local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CUseGiftKey = dataclass("CUseGiftKey", require("framework.net.protocol"))
CUseGiftKey.ProtocolType = 1246
CUseGiftKey.MaxSize = 65535
CUseGiftKey.giftkey = ""

function CUseGiftKey:Ctor(client)
  CUseGiftKey.super.Ctor(self, client)
end

function CUseGiftKey:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.giftkey) then
    return false
  end
  return true
end

function CUseGiftKey:Unmarshal(buffer)
  local ret = true
  ret, self.giftkey = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUseGiftKey
