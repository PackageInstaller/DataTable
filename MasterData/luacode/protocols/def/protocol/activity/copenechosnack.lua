local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenEchoSnack = dataclass("COpenEchoSnack", require("framework.net.protocol"))
COpenEchoSnack.ProtocolType = 2708
COpenEchoSnack.MaxSize = 65535

function COpenEchoSnack:Ctor(client)
  COpenEchoSnack.super.Ctor(self, client)
end

function COpenEchoSnack:Marshal(buffer)
  return true
end

function COpenEchoSnack:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenEchoSnack
