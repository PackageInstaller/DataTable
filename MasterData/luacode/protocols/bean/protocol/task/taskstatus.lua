local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local TaskStatus = dataclass("TaskStatus")
TaskStatus.ABANDON = -2
TaskStatus.UNACCEPT = -1
TaskStatus.COMMITED = 1
TaskStatus.FAILED = 2
TaskStatus.FINISHED = 3
TaskStatus.PROCESSING = 4
TaskStatus.ACCEPTED = 5

function TaskStatus:Ctor()
end

function TaskStatus:Marshal(buffer)
  return true
end

function TaskStatus:Unmarshal(buffer)
  local ret = true
  return ret
end

return TaskStatus
