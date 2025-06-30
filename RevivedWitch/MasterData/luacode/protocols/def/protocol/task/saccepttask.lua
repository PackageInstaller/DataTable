-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/saccepttask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAcceptTask = dataclass("SAcceptTask", require("framework.net.protocol"))
SAcceptTask.ProtocolType = 1602
SAcceptTask.MaxSize = 65535
SAcceptTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAcceptTask, _ENV
  ((SAcceptTask.super).Ctor)(self, client)
  self.taskinfo = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
end

SAcceptTask.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.taskinfo):Marshal(buffer) then
    return false
  end
  return true
end

SAcceptTask.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.taskinfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SAcceptTask

