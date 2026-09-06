local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshActivityTask = dataclass("SRefreshActivityTask", require("framework.net.protocol"))
SRefreshActivityTask.ProtocolType = 1631
SRefreshActivityTask.MaxSize = 65535
SRefreshActivityTask.activityID = 0

function SRefreshActivityTask:Ctor(client)
  SRefreshActivityTask.super.Ctor(self, client)
  self.taskinfo = require("protocols.bean.protocol.task.taskinfo").Create()
end

function SRefreshActivityTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not self.taskinfo:Marshal(buffer) then
    return false
  end
  return true
end

function SRefreshActivityTask:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  if not self.taskinfo:Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshActivityTask
