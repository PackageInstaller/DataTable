local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CDailyTaskForAccept = dataclass("CDailyTaskForAccept", require("framework.net.protocol"))
CDailyTaskForAccept.ProtocolType = 1615
CDailyTaskForAccept.MaxSize = 65535

function CDailyTaskForAccept:Ctor(client)
  CDailyTaskForAccept.super.Ctor(self, client)
end

function CDailyTaskForAccept:Marshal(buffer)
  return true
end

function CDailyTaskForAccept:Unmarshal(buffer)
  local ret = true
  return ret
end

return CDailyTaskForAccept
