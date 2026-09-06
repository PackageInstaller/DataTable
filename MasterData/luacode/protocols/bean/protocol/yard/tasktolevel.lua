local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TaskToLevel = dataclass("TaskToLevel")
TaskToLevel.taskId = 0
TaskToLevel.taskLevel = 0

function TaskToLevel:Ctor()
end

function TaskToLevel:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.taskLevel) then
    return false
  end
  return true
end

function TaskToLevel:Unmarshal(buffer)
  local ret = true
  ret, self.taskId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.taskLevel = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TaskToLevel
