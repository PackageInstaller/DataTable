-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgethalloweenreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetHalloweenReward = dataclass("CGetHalloweenReward", require("framework.net.protocol"))
CGetHalloweenReward.ProtocolType = 2514
CGetHalloweenReward.MaxSize = 65535
CGetHalloweenReward.rewardId = 0
CGetHalloweenReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetHalloweenReward
  ((CGetHalloweenReward.super).Ctor)(self, client)
end

CGetHalloweenReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardId) then
    return false
  end
  return true
end

CGetHalloweenReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetHalloweenReward

