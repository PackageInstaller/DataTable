local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CReceiveReturnMaxLevel = dataclass("CReceiveReturnMaxLevel", require("framework.net.protocol"))
CReceiveReturnMaxLevel.ProtocolType = 2741
CReceiveReturnMaxLevel.MaxSize = 65535

function CReceiveReturnMaxLevel:Ctor(client)
  CReceiveReturnMaxLevel.super.Ctor(self, client)
end

function CReceiveReturnMaxLevel:Marshal(buffer)
  return true
end

function CReceiveReturnMaxLevel:Unmarshal(buffer)
  local ret = true
  return ret
end

return CReceiveReturnMaxLevel
