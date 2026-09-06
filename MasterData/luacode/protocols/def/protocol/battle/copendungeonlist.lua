local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local COpenDungeonList = dataclass("COpenDungeonList", require("framework.net.protocol"))
COpenDungeonList.ProtocolType = 1910
COpenDungeonList.MaxSize = 65535

function COpenDungeonList:Ctor(client)
  COpenDungeonList.super.Ctor(self, client)
end

function COpenDungeonList:Marshal(buffer)
  return true
end

function COpenDungeonList:Unmarshal(buffer)
  local ret = true
  return ret
end

return COpenDungeonList
