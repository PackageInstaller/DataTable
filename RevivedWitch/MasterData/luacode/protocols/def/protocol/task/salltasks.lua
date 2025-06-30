-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/salltasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAllTasks = dataclass("SAllTasks", require("framework.net.protocol"))
SAllTasks.ProtocolType = 1607
SAllTasks.MaxSize = 655350
SAllTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAllTasks
  ((SAllTasks.super).Ctor)(self, client)
  self.majorTasks = {}
  self.branchTasks = {}
  self.dailyTasks = {}
  self.characterTasks = {}
  self.achieveTasks = {}
  self.weekBossTasks = {}
  self.taskChoices = {}
end

SAllTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.majorTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.majorTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.branchTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.branchTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.dailyTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.dailyTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.characterTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.characterTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.achieveTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.achieveTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.weekBossTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.weekBossTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  local length = (table.slen)(self.taskChoices)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.taskChoices)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SAllTasks.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.majorTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.majorTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R9 in 'UnsetPending'

    (self.branchTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.branchTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R10 in 'UnsetPending'

    (self.dailyTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.dailyTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R11 in 'UnsetPending'

    (self.characterTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.characterTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC140: Confused about usage of register: R12 in 'UnsetPending'

    (self.achieveTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.achieveTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC170: Confused about usage of register: R13 in 'UnsetPending'

    (self.weekBossTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.weekBossTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC200: Confused about usage of register: R14 in 'UnsetPending'

    (self.taskChoices)[i] = ((require("protocols.bean.protocol.task.choice")).Create)()
    if not ((self.taskChoices)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAllTasks

