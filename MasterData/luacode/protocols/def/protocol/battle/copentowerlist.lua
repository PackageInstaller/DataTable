local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenTowerList = dataclass("COpenTowerList", require("framework.net.protocol"))
COpenTowerList.ProtocolType = 1977
COpenTowerList.MaxSize = 65535

function COpenTowerList:Ctor(client)
  COpenTowerList.super.Ctor(self, client)
end

function COpenTowerList:Marshal(buffer)
  return true
end

function COpenTowerList:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenTowerList
