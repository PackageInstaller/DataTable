-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/taskimport.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local TaskImport = dataclass("TaskImport", require("framework.net.protocol"))
TaskImport.ProtocolType = 1600
TaskImport.MaxSize = 65535
TaskImport.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : TaskImport, _ENV
  ((TaskImport.super).Ctor)(self, client)
  self.b1 = ((require("protocols.bean.taskstatus")).Create)()
end

TaskImport.Marshal = function(self, buffer)
  -- function num : 0_1
  if not (self.b1):Marshal(buffer) then
    return false
  end
  return true
end

TaskImport.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  if not (self.b1):Unmarshal(buffer) then
    return false
  end
  return ret
end

return TaskImport

