local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TaskFinishProgress = dataclass("TaskFinishProgress")
TaskFinishProgress.status = 0
TaskFinishProgress.num = 0
TaskFinishProgress.LOCKED = 0
TaskFinishProgress.UNLOCKED = 1
TaskFinishProgress.FETCHED = 2

function TaskFinishProgress:Ctor()
end

function TaskFinishProgress:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.status) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.num) then
    return false
  end
  return true
end

function TaskFinishProgress:Unmarshal(buffer)
  local ret = true
  ret, self.status = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.num = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return TaskFinishProgress
