local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SBirthShare = dataclass("SBirthShare", require("framework.net.protocol"))
SBirthShare.ProtocolType = 2548
SBirthShare.MaxSize = 65535

function SBirthShare:Ctor(client)
  SBirthShare.super.Ctor(self, client)
end

function SBirthShare:Marshal(buffer)
  return true
end

function SBirthShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return SBirthShare
