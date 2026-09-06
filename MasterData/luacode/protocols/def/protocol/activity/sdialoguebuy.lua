local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDialogueBuy = dataclass("SDialogueBuy", require("framework.net.protocol"))
SDialogueBuy.ProtocolType = 2605
SDialogueBuy.MaxSize = 65535

function SDialogueBuy:Ctor(client)
  SDialogueBuy.super.Ctor(self, client)
end

function SDialogueBuy:Marshal(buffer)
  return true
end

function SDialogueBuy:Unmarshal(buffer)
  local ret = true
  return ret
end

return SDialogueBuy
