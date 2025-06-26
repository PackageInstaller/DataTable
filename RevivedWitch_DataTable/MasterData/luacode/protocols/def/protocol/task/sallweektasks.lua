-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/sallweektasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAllWeekTasks = dataclass("SAllWeekTasks", require("framework.net.protocol"))
SAllWeekTasks.ProtocolType = 1625
SAllWeekTasks.MaxSize = 65535
SAllWeekTasks.currentActiveValue = 0
SAllWeekTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAllWeekTasks
  ((SAllWeekTasks.super).Ctor)(self, client)
  self.activeValues = {}
  self.weekTasks = {}
end

SAllWeekTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.activeValues)) then
    return false
  end
  for key,value in pairs(self.activeValues) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC18) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentActiveValue) then
    return false
  end
  local length = (table.slen)(self.weekTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC60: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.weekTasks)[i]):Marshal(R9_PC18) then
      return false
    end
  end
  return true
end

SAllWeekTasks.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
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
    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R10 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R11 in 'UnsetPending'

    (self.weekTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.weekTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SAllWeekTasks

