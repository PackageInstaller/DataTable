-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivebeatclownreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveBeatClownReward = dataclass("CReceiveBeatClownReward", require("framework.net.protocol"))
CReceiveBeatClownReward.ProtocolType = 2617
CReceiveBeatClownReward.MaxSize = 65535
CReceiveBeatClownReward.times = 0
CReceiveBeatClownReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveBeatClownReward
  ((CReceiveBeatClownReward.super).Ctor)(self, client)
end

CReceiveBeatClownReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.times) then
    return false
  end
  return true
end

CReceiveBeatClownReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveBeatClownReward

