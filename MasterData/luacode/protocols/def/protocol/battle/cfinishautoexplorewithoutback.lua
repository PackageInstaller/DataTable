local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CFinishAutoExploreWithoutBack = dataclass("CFinishAutoExploreWithoutBack", require("framework.net.protocol"))
CFinishAutoExploreWithoutBack.ProtocolType = 4131
CFinishAutoExploreWithoutBack.MaxSize = 65535

function CFinishAutoExploreWithoutBack:Ctor(client)
  CFinishAutoExploreWithoutBack.super.Ctor(self, client)
end

function CFinishAutoExploreWithoutBack:Marshal(buffer)
  return true
end

function CFinishAutoExploreWithoutBack:Unmarshal(buffer)
  local ret = true
  return ret
end

return CFinishAutoExploreWithoutBack
