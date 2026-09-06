local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SActivityTasks = dataclass("SActivityTasks", require("framework.net.protocol"))
SActivityTasks.ProtocolType = 1630
SActivityTasks.MaxSize = 65535
SActivityTasks.activityID = 0
SActivityTasks.refresh = 0

function SActivityTasks:Ctor(client)
  SActivityTasks.super.Ctor(self, client)
  self.activityTasks = {}
end

function SActivityTasks:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  local length = table.slen(self.activityTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.activityTasks[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.refresh) then
    return false
  end
  return true
end

function SActivityTasks:Unmarshal(buffer)
  local ret = true
  ret, self.activityID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.activityTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.activityTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.refresh = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SActivityTasks
