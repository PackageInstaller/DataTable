-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/srefreshtask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshTask = dataclass("SRefreshTask", require("framework.net.protocol"))
SRefreshTask.ProtocolType = 1616
SRefreshTask.MaxSize = 65535
SRefreshTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshTask, _ENV
  ((SRefreshTask.super).Ctor)(self, client)
  self.taskinfo = ((require("protocols.bean.protocol.task.taskinfo")).Create)()
end

SRefreshTask.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.taskinfo):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshTask.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.taskinfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshTask

