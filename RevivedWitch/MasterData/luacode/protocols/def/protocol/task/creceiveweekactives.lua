-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/task/creceiveweekactives.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveWeekActives = dataclass("CReceiveWeekActives", require("framework.net.protocol"))
CReceiveWeekActives.ProtocolType = 1626
CReceiveWeekActives.MaxSize = 65535
CReceiveWeekActives.value = 0
CReceiveWeekActives.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveWeekActives
  ((CReceiveWeekActives.super).Ctor)(self, client)
end

CReceiveWeekActives.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.value) then
    return false
  end
  return true
end

CReceiveWeekActives.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveWeekActives

