-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivescorereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveScoreReward = dataclass("CReceiveScoreReward", require("framework.net.protocol"))
CReceiveScoreReward.ProtocolType = 2536
CReceiveScoreReward.MaxSize = 65535
CReceiveScoreReward.scoreType = 0
CReceiveScoreReward.rewardId = 0
CReceiveScoreReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveScoreReward
  ((CReceiveScoreReward.super).Ctor)(self, client)
end

CReceiveScoreReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.scoreType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardId) then
    return false
  end
  return true
end

CReceiveScoreReward.Unmarshal = function(self, buffer)
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

return CReceiveScoreReward

