local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TaskImport = dataclass("TaskImport", require("framework.net.protocol"))
TaskImport.ProtocolType = 1600
TaskImport.MaxSize = 65535

function TaskImport:Ctor(client)
  TaskImport.super.Ctor(self, client)
  self.b1 = require("protocols.bean.taskstatus").Create()
end

function TaskImport:Marshal(buffer)
  if not self.b1:Marshal(buffer) then
    return false
  end
  return true
end

function TaskImport:Unmarshal(buffer)
  local ret = true
  if not self.b1:Unmarshal(buffer) then
    return false
  end
  return ret
end

return TaskImport
