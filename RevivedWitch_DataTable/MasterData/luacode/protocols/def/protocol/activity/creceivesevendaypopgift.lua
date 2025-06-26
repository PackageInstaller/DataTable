-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivesevendaypopgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveSevenDayPopGift = dataclass("CReceiveSevenDayPopGift", require("framework.net.protocol"))
CReceiveSevenDayPopGift.ProtocolType = 2744
CReceiveSevenDayPopGift.MaxSize = 65535
CReceiveSevenDayPopGift.rewardId = 0
CReceiveSevenDayPopGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveSevenDayPopGift
  ((CReceiveSevenDayPopGift.super).Ctor)(self, client)
end

CReceiveSevenDayPopGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardId) then
    return false
  end
  return true
end

CReceiveSevenDayPopGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveSevenDayPopGift

