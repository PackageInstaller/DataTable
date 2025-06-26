-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/cacceptactivitytask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAcceptActivityTask = dataclass("CAcceptActivityTask", require("framework.net.protocol"))
CAcceptActivityTask.ProtocolType = 1632
CAcceptActivityTask.MaxSize = 65535
CAcceptActivityTask.activityID = 0
CAcceptActivityTask.taskID = 0
CAcceptActivityTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAcceptActivityTask
  ((CAcceptActivityTask.super).Ctor)(self, client)
end

CAcceptActivityTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskID) then
    return false
  end
  return true
end

CAcceptActivityTask.Unmarshal = function(self, buffer)
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

return CAcceptActivityTask

