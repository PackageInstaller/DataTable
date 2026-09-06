local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshTask = dataclass("SRefreshTask", require("framework.net.protocol"))
SRefreshTask.ProtocolType = 2328
SRefreshTask.MaxSize = 65535

function SRefreshTask:Ctor(client)
  SRefreshTask.super.Ctor(self, client)
  self.task = require("protocols.bean.protocol.yard.task").Create()
end

function SRefreshTask:Marshal(buffer)
  if not self.task:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshTask:Unmarshal(buffer)
  local ret = true
  if not self.task:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshTask
