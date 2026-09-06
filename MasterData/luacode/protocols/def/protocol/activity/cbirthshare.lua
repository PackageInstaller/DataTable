local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CBirthShare = dataclass("CBirthShare", require("framework.net.protocol"))
CBirthShare.ProtocolType = 2547
CBirthShare.MaxSize = 65535

function CBirthShare:Ctor(client)
  CBirthShare.super.Ctor(self, client)
end

function CBirthShare:Marshal(buffer)
  return true
end

function CBirthShare:Unmarshal(buffer)
  local ret = true
  return ret
end

return CBirthShare
