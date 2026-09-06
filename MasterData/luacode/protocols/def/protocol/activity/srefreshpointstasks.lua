local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshPointsTasks = dataclass("SRefreshPointsTasks", require("framework.net.protocol"))
SRefreshPointsTasks.ProtocolType = 2440
SRefreshPointsTasks.MaxSize = 65535
SRefreshPointsTasks.activityID = 0

function SRefreshPointsTasks:Ctor(client)
  SRefreshPointsTasks.super.Ctor(self, client)
  self.tasks = {}
end

function SRefreshPointsTasks:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.activityID) then
    return false
  end
  local length = table.slen(self.tasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.tasks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshPointsTasks:Unmarshal(buffer)
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
    self.tasks[i] = require("protocols.bean.protocol.activity.collectiontask").Create()
    if not self.tasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshPointsTasks
