local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CActivityTasks = dataclass("CActivityTasks", require("framework.net.protocol"))
CActivityTasks.ProtocolType = 1629
CActivityTasks.MaxSize = 65535
CActivityTasks.activityID = 0
CActivityTasks.SEVEN_DAYS = 1
CActivityTasks.JIGSAW_PUZZLE = 2
CActivityTasks.HALLOWEEN = 3
CActivityTasks.DOUBLE_ELEVEN = 4
CActivityTasks.BIRTH_DAY = 5
CActivityTasks.BACK_PLAYER = 6
CActivityTasks.CHILDREN_DAY = 7
CActivityTasks.ANNIVERSARY = 8
CActivityTasks.ANNIVERSARY_DRAW = 9
CActivityTasks.TASK_SHOP = 10

function CActivityTasks:Ctor(client)
  CActivityTasks.super.Ctor(self, client)
end

function CActivityTasks:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  return true
end

function CActivityTasks:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityTasks
