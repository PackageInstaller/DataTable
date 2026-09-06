local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenTrain = dataclass("COpenTrain", require("framework.net.protocol"))
COpenTrain.ProtocolType = 2483
COpenTrain.MaxSize = 65535

function COpenTrain:Ctor(client)
  COpenTrain.super.Ctor(self, client)
end

function COpenTrain:Marshal(buffer)
  return true
end

function COpenTrain:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenTrain
