-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/task/taskstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local TaskStatus = dataclass("TaskStatus")
TaskStatus.ABANDON = -2
TaskStatus.UNACCEPT = -1
TaskStatus.COMMITED = 1
TaskStatus.FAILED = 2
TaskStatus.FINISHED = 3
TaskStatus.PROCESSING = 4
TaskStatus.ACCEPTED = 5
TaskStatus.Ctor = function(self)
  -- function num : 0_0
end

TaskStatus.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

TaskStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return TaskStatus

