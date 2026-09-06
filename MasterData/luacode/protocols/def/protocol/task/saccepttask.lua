local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAcceptTask = dataclass("SAcceptTask", require("framework.net.protocol"))
SAcceptTask.ProtocolType = 1602
SAcceptTask.MaxSize = 65535

function SAcceptTask:Ctor(client)
  SAcceptTask.super.Ctor(self, client)
  self.taskinfo = require("protocols.bean.protocol.task.taskinfo").Create()
end

function SAcceptTask:Marshal(buffer)
  if not self.taskinfo:Marshal(buffer) then
    return false
  end
  return true
end

function SAcceptTask:Unmarshal(buffer)
  local ret = true
  if not self.taskinfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAcceptTask
