-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/srefreshactivitytask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshActivityTask = dataclass("SRefreshActivityTask", require("framework.net.protocol"))
SRefreshActivityTask.ProtocolType = 1631
SRefreshActivityTask.MaxSize = 65535
SRefreshActivityTask.activityID = 0
SRefreshActivityTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshActivityTask, _ENV
  ((SRefreshActivityTask.super).Ctor)(self, client)
  self.taskinfo = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
end

SRefreshActivityTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (self.taskinfo):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshActivityTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.taskinfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshActivityTask

