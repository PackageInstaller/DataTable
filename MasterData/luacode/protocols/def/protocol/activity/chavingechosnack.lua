local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CHavingEchoSnack = dataclass("CHavingEchoSnack", require("framework.net.protocol"))
CHavingEchoSnack.ProtocolType = 2710
CHavingEchoSnack.MaxSize = 65536

function CHavingEchoSnack:Ctor(client)
  CHavingEchoSnack.super.Ctor(self, client)
end

function CHavingEchoSnack:Marshal(buffer)
  return true
end

function CHavingEchoSnack:Unmarshal(buffer)
  local ret = true
  return ret
end

return CHavingEchoSnack
