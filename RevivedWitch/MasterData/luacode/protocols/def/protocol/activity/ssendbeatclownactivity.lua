-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendbeatclownactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendBeatClownActivity = dataclass("SSendBeatClownActivity", require("framework.net.protocol"))
SSendBeatClownActivity.ProtocolType = 2616
SSendBeatClownActivity.MaxSize = 65535
SSendBeatClownActivity.state = 0
SSendBeatClownActivity.receiveTimes = 0
SSendBeatClownActivity.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendBeatClownActivity
  ((SSendBeatClownActivity.super).Ctor)(self, client)
end

SSendBeatClownActivity.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.state) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.receiveTimes) then
    return false
  end
  return true
end

SSendBeatClownActivity.Unmarshal = function(self, buffer)
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

return SSendBeatClownActivity

