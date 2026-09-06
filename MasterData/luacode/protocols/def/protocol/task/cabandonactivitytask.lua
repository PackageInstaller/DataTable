local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAbandonActivityTask = dataclass("CAbandonActivityTask", require("framework.net.protocol"))
CAbandonActivityTask.ProtocolType = 1633
CAbandonActivityTask.MaxSize = 65535
CAbandonActivityTask.activityID = 0
CAbandonActivityTask.taskID = 0

function CAbandonActivityTask:Ctor(client)
  CAbandonActivityTask.super.Ctor(self, client)
end

function CAbandonActivityTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskID) then
    return false
  end
  return true
end

function CAbandonActivityTask:Unmarshal(buffer)
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

return CAbandonActivityTask
