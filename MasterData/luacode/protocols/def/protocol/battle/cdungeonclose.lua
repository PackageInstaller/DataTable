local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDungeonClose = dataclass("CDungeonClose", require("framework.net.protocol"))
CDungeonClose.ProtocolType = 1945
CDungeonClose.MaxSize = 65535

function CDungeonClose:Ctor(client)
  CDungeonClose.super.Ctor(self, client)
end

function CDungeonClose:Marshal(buffer)
  return true
end

function CDungeonClose:Unmarshal(buffer)
  local ret = true
  return ret
end

return CDungeonClose
