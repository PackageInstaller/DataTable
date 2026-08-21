-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/ccommittask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCommitTask = dataclass("CCommitTask", require("framework.net.protocol"))
CCommitTask.ProtocolType = 1603
CCommitTask.MaxSize = 65535
CCommitTask.taskid = 0
CCommitTask.agCoinTask = 0
CCommitTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCommitTask
  ((CCommitTask.super).Ctor)(self, client)
end

CCommitTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.taskid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.agCoinTask) then
    return false
  end
  return true
end

CCommitTask.Unmarshal = function(self, buffer)
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

return CCommitTask

