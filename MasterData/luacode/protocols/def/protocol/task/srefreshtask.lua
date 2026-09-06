local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshTask = dataclass("SRefreshTask", require("framework.net.protocol"))
SRefreshTask.ProtocolType = 1616
SRefreshTask.MaxSize = 65535

function SRefreshTask:Ctor(client)
  SRefreshTask.super.Ctor(self, client)
  self.taskinfo = require("protocols.bean.protocol.task.taskinfo").Create()
end

function SRefreshTask:Marshal(buffer)
  if not self.taskinfo:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshTask:Unmarshal(buffer)
  local ret = true
  if not self.taskinfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshTask
