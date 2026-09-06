local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshCavernTask = dataclass("SRefreshCavernTask", require("framework.net.protocol"))
SRefreshCavernTask.ProtocolType = 2319
SRefreshCavernTask.MaxSize = 65535

function SRefreshCavernTask:Ctor(client)
  SRefreshCavernTask.super.Ctor(self, client)
  self.task = require("protocols.bean.protocol.yard.caverntask").Create()
end

function SRefreshCavernTask:Marshal(buffer)
  if not self.task:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshCavernTask:Unmarshal(buffer)
  local ret = true
  if not self.task:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshCavernTask
