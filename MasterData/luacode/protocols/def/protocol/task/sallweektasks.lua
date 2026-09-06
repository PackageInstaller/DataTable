local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAllWeekTasks = dataclass("SAllWeekTasks", require("framework.net.protocol"))
SAllWeekTasks.ProtocolType = 1625
SAllWeekTasks.MaxSize = 65535
SAllWeekTasks.currentActiveValue = 0

function SAllWeekTasks:Ctor(client)
  SAllWeekTasks.super.Ctor(self, client)
  self.activeValues = {}
  self.weekTasks = {}
end

function SAllWeekTasks:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.activeValues)) then
    return false
  end
  for key, value in pairs(self.activeValues) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currentActiveValue) then
    return false
  end
  local length = table.slen(self.weekTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.weekTasks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SAllWeekTasks:Unmarshal(buffer)
  local ret = true
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.activeValues[key] = value
  end
  ret, self.currentActiveValue = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.weekTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.weekTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAllWeekTasks
