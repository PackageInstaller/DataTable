local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenDoubleElevenActivity = dataclass("COpenDoubleElevenActivity", require("framework.net.protocol"))
COpenDoubleElevenActivity.ProtocolType = 2521
COpenDoubleElevenActivity.MaxSize = 65535

function COpenDoubleElevenActivity:Ctor(client)
  COpenDoubleElevenActivity.super.Ctor(self, client)
end

function COpenDoubleElevenActivity:Marshal(buffer)
  return true
end

function COpenDoubleElevenActivity:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenDoubleElevenActivity
