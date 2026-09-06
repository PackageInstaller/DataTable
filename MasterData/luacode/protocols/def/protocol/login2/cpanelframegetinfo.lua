local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPanelFrameGetInfo = dataclass("CPanelFrameGetInfo", require("framework.net.protocol"))
CPanelFrameGetInfo.ProtocolType = 5201
CPanelFrameGetInfo.MaxSize = 65535

function CPanelFrameGetInfo:Ctor(client)
  CPanelFrameGetInfo.super.Ctor(self, client)
end

function CPanelFrameGetInfo:Marshal(buffer)
  return true
end

function CPanelFrameGetInfo:Unmarshal(buffer)
  local ret = true
  return ret
end

return CPanelFrameGetInfo
