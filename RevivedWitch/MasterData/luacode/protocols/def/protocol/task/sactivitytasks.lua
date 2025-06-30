-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/sactivitytasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SActivityTasks = dataclass("SActivityTasks", require("framework.net.protocol"))
SActivityTasks.ProtocolType = 1630
SActivityTasks.MaxSize = 65535
SActivityTasks.activityID = 0
SActivityTasks.refresh = 0
SActivityTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SActivityTasks
  ((SActivityTasks.super).Ctor)(self, client)
  self.activityTasks = {}
end

SActivityTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  local length = (table.slen)(self.activityTasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.activityTasks)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.refresh) then
    return false
  end
  return true
end

SActivityTasks.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
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
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.activityTasks)[i] = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
    if not ((self.activityTasks)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SActivityTasks

