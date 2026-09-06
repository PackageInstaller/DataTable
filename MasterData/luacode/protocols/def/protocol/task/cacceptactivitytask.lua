local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAcceptActivityTask = dataclass("CAcceptActivityTask", require("framework.net.protocol"))
CAcceptActivityTask.ProtocolType = 1632
CAcceptActivityTask.MaxSize = 65535
CAcceptActivityTask.activityID = 0
CAcceptActivityTask.taskID = 0

function CAcceptActivityTask:Ctor(client)
  CAcceptActivityTask.super.Ctor(self, client)
end

function CAcceptActivityTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskID) then
    return false
  end
  return true
end

function CAcceptActivityTask:Unmarshal(buffer)
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

return CAcceptActivityTask
