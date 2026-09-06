local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CWitchInAgainstBossUpLv = dataclass("CWitchInAgainstBossUpLv", require("framework.net.protocol"))
CWitchInAgainstBossUpLv.ProtocolType = 2669
CWitchInAgainstBossUpLv.MaxSize = 65535

function CWitchInAgainstBossUpLv:Ctor(client)
  CWitchInAgainstBossUpLv.super.Ctor(self, client)
end

function CWitchInAgainstBossUpLv:Marshal(buffer)
  return true
end

function CWitchInAgainstBossUpLv:Unmarshal(buffer)
  local ret = true
  return ret
end

return CWitchInAgainstBossUpLv
