-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cabandonactivitytask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAbandonActivityTask = dataclass("CAbandonActivityTask", require("framework.net.protocol"))
CAbandonActivityTask.ProtocolType = 1633
CAbandonActivityTask.MaxSize = 65535
CAbandonActivityTask.activityID = 0
CAbandonActivityTask.taskID = 0
CAbandonActivityTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAbandonActivityTask
  ((CAbandonActivityTask.super).Ctor)(self, client)
end

CAbandonActivityTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskID) then
    return false
  end
  return true
end

CAbandonActivityTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAbandonActivityTask

