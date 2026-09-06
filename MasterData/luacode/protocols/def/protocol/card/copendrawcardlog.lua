local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenDrawCardLog = dataclass("COpenDrawCardLog", require("framework.net.protocol"))
COpenDrawCardLog.ProtocolType = 1510
COpenDrawCardLog.MaxSize = 65535

function COpenDrawCardLog:Ctor(client)
  COpenDrawCardLog.super.Ctor(self, client)
end

function COpenDrawCardLog:Marshal(buffer)
  return true
end

function COpenDrawCardLog:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenDrawCardLog
