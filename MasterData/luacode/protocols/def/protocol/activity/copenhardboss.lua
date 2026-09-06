local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenHardBoss = dataclass("COpenHardBoss", require("framework.net.protocol"))
COpenHardBoss.ProtocolType = 2540
COpenHardBoss.MaxSize = 65536

function COpenHardBoss:Ctor(client)
  COpenHardBoss.super.Ctor(self, client)
end

function COpenHardBoss:Marshal(buffer)
  return true
end

function COpenHardBoss:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenHardBoss
