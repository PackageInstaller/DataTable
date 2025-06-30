-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/salarm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAlarm = dataclass("SAlarm", require("framework.net.protocol"))
SAlarm.ProtocolType = 2274
SAlarm.MaxSize = 65535
SAlarm.result = 0
SAlarm.SUCCESS = 0
SAlarm.FAIL = 1
SAlarm.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAlarm
  ((SAlarm.super).Ctor)(self, client)
end

SAlarm.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SAlarm.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAlarm

