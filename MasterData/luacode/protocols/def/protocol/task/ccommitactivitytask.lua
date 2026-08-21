-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/ccommitactivitytask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCommitActivityTask = dataclass("CCommitActivityTask", require("framework.net.protocol"))
CCommitActivityTask.ProtocolType = 1635
CCommitActivityTask.MaxSize = 65535
CCommitActivityTask.activityID = 0
CCommitActivityTask.taskID = 0
CCommitActivityTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCommitActivityTask
  ((CCommitActivityTask.super).Ctor)(self, client)
end

CCommitActivityTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskID) then
    return false
  end
  return true
end

CCommitActivityTask.Unmarshal = function(self, buffer)
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

return CCommitActivityTask

