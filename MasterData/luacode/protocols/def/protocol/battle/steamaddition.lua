local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local STeamAddition = dataclass("STeamAddition", require("framework.net.protocol"))
STeamAddition.ProtocolType = 4148
STeamAddition.MaxSize = 65535

function STeamAddition:Ctor(client)
  STeamAddition.super.Ctor(self, client)
end

function STeamAddition:Marshal(buffer)
  return true
end

function STeamAddition:Unmarshal(buffer)
  local ret = true
  return ret
end

return STeamAddition
