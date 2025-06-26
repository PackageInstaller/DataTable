-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenbirthreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SopenBirthReward = dataclass("SopenBirthReward", require("framework.net.protocol"))
SopenBirthReward.ProtocolType = 2546
SopenBirthReward.MaxSize = 65535
SopenBirthReward.rewardId = 0
SopenBirthReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SopenBirthReward
  ((SopenBirthReward.super).Ctor)(self, client)
end

SopenBirthReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardId) then
    return false
  end
  return true
end

SopenBirthReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SopenBirthReward

