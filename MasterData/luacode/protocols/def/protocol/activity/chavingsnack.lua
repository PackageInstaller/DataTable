local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CHavingSnack = dataclass("CHavingSnack", require("framework.net.protocol"))
CHavingSnack.ProtocolType = 2509
CHavingSnack.MaxSize = 65536

function CHavingSnack:Ctor(client)
  CHavingSnack.super.Ctor(self, client)
end

function CHavingSnack:Marshal(buffer)
  return true
end

function CHavingSnack:Unmarshal(buffer)
  local ret = true
  return ret
end

return CHavingSnack
