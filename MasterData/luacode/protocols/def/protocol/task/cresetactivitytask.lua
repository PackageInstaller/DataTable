local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CResetActivityTask = dataclass("CResetActivityTask", require("framework.net.protocol"))
CResetActivityTask.ProtocolType = 1634
CResetActivityTask.MaxSize = 65535
CResetActivityTask.activityID = 0
CResetActivityTask.taskID = 0

function CResetActivityTask:Ctor(client)
  CResetActivityTask.super.Ctor(self, client)
end

function CResetActivityTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskID) then
    return false
  end
  return true
end

function CResetActivityTask:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.taskID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CResetActivityTask
