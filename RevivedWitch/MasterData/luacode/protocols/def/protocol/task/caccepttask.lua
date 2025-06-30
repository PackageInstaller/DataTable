-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/caccepttask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAcceptTask = dataclass("CAcceptTask", require("framework.net.protocol"))
CAcceptTask.ProtocolType = 1601
CAcceptTask.MaxSize = 65535
CAcceptTask.taskid = 0
CAcceptTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAcceptTask
  ((CAcceptTask.super).Ctor)(self, client)
end

CAcceptTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskid) then
    return false
  end
  return true
end

CAcceptTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAcceptTask

