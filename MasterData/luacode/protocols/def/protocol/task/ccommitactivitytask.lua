local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CCommitActivityTask = dataclass("CCommitActivityTask", require("framework.net.protocol"))
CCommitActivityTask.ProtocolType = 1635
CCommitActivityTask.MaxSize = 65535
CCommitActivityTask.activityID = 0
CCommitActivityTask.taskID = 0

function CCommitActivityTask:Ctor(client)
  CCommitActivityTask.super.Ctor(self, client)
end

function CCommitActivityTask:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskID) then
    return false
  end
  return true
end

function CCommitActivityTask:Unmarshal(buffer)
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

return CCommitActivityTask
