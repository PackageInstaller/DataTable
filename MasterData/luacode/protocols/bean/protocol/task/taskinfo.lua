local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TaskInfo = dataclass("TaskInfo")
TaskInfo.taskid = 0
TaskInfo.taskstatus = 0
TaskInfo.acceptTime = 0
TaskInfo.visitable = 0

function TaskInfo:Ctor()
  self.conditions = {}
end

function TaskInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskid) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskstatus) then
    return false
  end
  local length = table.slen(self.conditions)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.conditions[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.acceptTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.visitable) then
    return false
  end
  return true
end

function TaskInfo:Unmarshal(buffer)
  local ret = true
  ret, self.taskid = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.taskstatus = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.conditions[i] = require("protocols.bean.protocol.task.condition").Create()
    if not self.conditions[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.acceptTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.visitable = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TaskInfo
