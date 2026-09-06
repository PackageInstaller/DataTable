local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenParty = dataclass("COpenParty", require("framework.net.protocol"))
COpenParty.ProtocolType = 5005
COpenParty.MaxSize = 65535

function COpenParty:Ctor(client)
  COpenParty.super.Ctor(self, client)
end

function COpenParty:Marshal(buffer)
  return true
end

function COpenParty:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenParty
