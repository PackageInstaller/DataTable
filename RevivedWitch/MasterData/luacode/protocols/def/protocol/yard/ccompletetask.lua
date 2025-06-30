-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ccompletetask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCompleteTask = dataclass("CCompleteTask", require("framework.net.protocol"))
CCompleteTask.ProtocolType = 2312
CCompleteTask.MaxSize = 65535
CCompleteTask.id = 0
CCompleteTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCompleteTask
  ((CCompleteTask.super).Ctor)(self, client)
end

CCompleteTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CCompleteTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCompleteTask

