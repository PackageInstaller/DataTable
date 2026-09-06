local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetMailList = dataclass("CGetMailList", require("framework.net.protocol"))
CGetMailList.ProtocolType = 1401
CGetMailList.MaxSize = 65535

function CGetMailList:Ctor(client)
  CGetMailList.super.Ctor(self, client)
end

function CGetMailList:Marshal(buffer)
  return true
end

function CGetMailList:Unmarshal(buffer)
  local ret = true
  return ret
end

return CGetMailList
