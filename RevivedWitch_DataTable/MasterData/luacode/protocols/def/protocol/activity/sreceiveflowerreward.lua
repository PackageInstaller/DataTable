-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceiveflowerreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveFlowerReward = dataclass("SReceiveFlowerReward", require("framework.net.protocol"))
SReceiveFlowerReward.ProtocolType = 2603
SReceiveFlowerReward.MaxSize = 65535
SReceiveFlowerReward.rewardType = 0
SReceiveFlowerReward.id = 0
SReceiveFlowerReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveFlowerReward
  ((SReceiveFlowerReward.super).Ctor)(self, client)
end

SReceiveFlowerReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

SReceiveFlowerReward.Unmarshal = function(self, buffer)
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

return SReceiveFlowerReward

