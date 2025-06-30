-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/sdailytaskforaccept.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDailyTaskForAccept = dataclass("SDailyTaskForAccept", require("framework.net.protocol"))
SDailyTaskForAccept.ProtocolType = 1609
SDailyTaskForAccept.MaxSize = 65535
SDailyTaskForAccept.dailyRefreshTime = 0
SDailyTaskForAccept.totalRefresh = 0
SDailyTaskForAccept.currentActiveValue = 0
SDailyTaskForAccept.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDailyTaskForAccept
  ((SDailyTaskForAccept.super).Ctor)(self, client)
  self.activeValues = {}
  self.dailyTasks = {}
end

SDailyTaskForAccept.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dailyRefreshTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalRefresh) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.activeValues)) then
    return false
  end
  for key,value in pairs(self.activeValues) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentActiveValue) then
    return false
  end
  local length = (table.slen)(self.dailyTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC76: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.dailyTasks)[i]):Marshal(R9_PC34) then
      return false
    end
  end
  return true
end

SDailyTaskForAccept.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.activeValues)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R11 in 'UnsetPending'

    (self.dailyTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.dailyTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SDailyTaskForAccept

