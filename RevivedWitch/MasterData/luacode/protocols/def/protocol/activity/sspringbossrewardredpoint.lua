-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sspringbossrewardredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSpringBossRewardRedPoint = dataclass("SSpringBossRewardRedPoint", require("framework.net.protocol"))
SSpringBossRewardRedPoint.ProtocolType = 2608
SSpringBossRewardRedPoint.MaxSize = 65535
SSpringBossRewardRedPoint.show = 0
SSpringBossRewardRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSpringBossRewardRedPoint
  ((SSpringBossRewardRedPoint.super).Ctor)(self, client)
end

SSpringBossRewardRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.show) then
    return false
  end
  return true
end

SSpringBossRewardRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSpringBossRewardRedPoint

