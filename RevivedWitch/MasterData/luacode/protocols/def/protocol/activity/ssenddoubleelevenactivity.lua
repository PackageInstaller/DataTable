-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssenddoubleelevenactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendDoubleElevenActivity = dataclass("SSendDoubleElevenActivity", require("framework.net.protocol"))
SSendDoubleElevenActivity.ProtocolType = 2520
SSendDoubleElevenActivity.MaxSize = 65535
SSendDoubleElevenActivity.state = 0
SSendDoubleElevenActivity.startTime = 0
SSendDoubleElevenActivity.endTime = 0
SSendDoubleElevenActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendDoubleElevenActivity
  ((SSendDoubleElevenActivity.super).Ctor)(self, client)
end

SSendDoubleElevenActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.startTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endTime) then
    return false
  end
  return true
end

SSendDoubleElevenActivity.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendDoubleElevenActivity

