local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SAllTasks = dataclass("SAllTasks", require("framework.net.protocol"))
SAllTasks.ProtocolType = 1607
SAllTasks.MaxSize = 655350

function SAllTasks:Ctor(client)
  SAllTasks.super.Ctor(self, client)
  self.majorTasks = {}
  self.branchTasks = {}
  self.dailyTasks = {}
  self.characterTasks = {}
  self.achieveTasks = {}
  self.weekBossTasks = {}
  self.taskChoices = {}
end

function SAllTasks:Marshal(buffer)
  local length = table.slen(self.majorTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.majorTasks[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.branchTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.branchTasks[i]:Marshal(buffer) then
      return false
    end
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
  local length = table.slen(self.characterTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.characterTasks[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.achieveTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.achieveTasks[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.weekBossTasks)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.weekBossTasks[i]:Marshal(buffer) then
      return false
    end
  end
  local length = table.slen(self.taskChoices)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.taskChoices[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SAllTasks:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.majorTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.majorTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.branchTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.branchTasks[i]:Unmarshal(buffer) then
      return false
    end
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
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.characterTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.characterTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.achieveTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.achieveTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.weekBossTasks[i] = require("protocols.bean.protocol.task.taskinfo").Create()
    if not self.weekBossTasks[i]:Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.taskChoices[i] = require("protocols.bean.protocol.task.choice").Create()
    if not self.taskChoices[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAllTasks
