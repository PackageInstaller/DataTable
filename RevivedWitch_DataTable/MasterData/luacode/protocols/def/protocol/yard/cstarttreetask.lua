-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cstarttreetask.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartTreeTask = dataclass("CStartTreeTask", require("framework.net.protocol"))
CStartTreeTask.ProtocolType = 2304
CStartTreeTask.MaxSize = 65535
CStartTreeTask.buildId = 0
CStartTreeTask.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartTreeTask
  ((CStartTreeTask.super).Ctor)(self, client)
end

CStartTreeTask.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buildId) then
    return false
  end
  return true
end

CStartTreeTask.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CStartTreeTask

