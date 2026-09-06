local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveMaxLevel = dataclass("CReceiveMaxLevel", require("framework.net.protocol"))
CReceiveMaxLevel.ProtocolType = 2409
CReceiveMaxLevel.MaxSize = 65535

function CReceiveMaxLevel:Ctor(client)
  CReceiveMaxLevel.super.Ctor(self, client)
end

function CReceiveMaxLevel:Marshal(buffer)
  return true
end

function CReceiveMaxLevel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReceiveMaxLevel
