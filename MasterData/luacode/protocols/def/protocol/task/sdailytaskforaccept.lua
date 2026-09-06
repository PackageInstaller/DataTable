local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SDailyTaskForAccept = dataclass("SDailyTaskForAccept", require("framework.net.protocol"))
SDailyTaskForAccept.ProtocolType = 1609
SDailyTaskForAccept.MaxSize = 65535
SDailyTaskForAccept.dailyRefreshTime = 0
SDailyTaskForAccept.totalRefresh = 0
SDailyTaskForAccept.currentActiveValue = 0

function SDailyTaskForAccept:Ctor(client)
  SDailyTaskForAccept.super.Ctor(self, client)
  self.activeValues = {}
  self.dailyTasks = {}
end

function SDailyTaskForAccept:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.dailyRefreshTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.totalRefresh) then
    return false
  end
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
  local length = table.slen(self.dailyTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.dailyTasks[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SDailyTaskForAccept:Unmarshal(buffer)
  local ret = true
  ret, self.dailyRefreshTime = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.totalRefresh = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
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
    self.dailyTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.dailyTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SDailyTaskForAccept
