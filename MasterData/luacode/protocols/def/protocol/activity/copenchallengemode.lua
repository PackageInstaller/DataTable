local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenChallengeMode = dataclass("COpenChallengeMode", require("framework.net.protocol"))
COpenChallengeMode.ProtocolType = 2729
COpenChallengeMode.MaxSize = 65535

function COpenChallengeMode:Ctor(client)
  COpenChallengeMode.super.Ctor(self, client)
end

function COpenChallengeMode:Marshal(buffer)
  return true
end

function COpenChallengeMode:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenChallengeMode
