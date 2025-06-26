-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cactivitytasks.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
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
CActivityTasks.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CActivityTasks
  ((CActivityTasks.super).Ctor)(self, client)
end

CActivityTasks.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  return true
end

CActivityTasks.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CActivityTasks

