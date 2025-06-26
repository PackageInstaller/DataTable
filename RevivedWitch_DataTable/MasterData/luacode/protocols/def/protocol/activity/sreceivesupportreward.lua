-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceivesupportreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveSupportReward = dataclass("SReceiveSupportReward", require("framework.net.protocol"))
SReceiveSupportReward.ProtocolType = 2567
SReceiveSupportReward.MaxSize = 65535
SReceiveSupportReward.rewardType = 0
SReceiveSupportReward.id = 0
SReceiveSupportReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveSupportReward
  ((SReceiveSupportReward.super).Ctor)(self, client)
end

SReceiveSupportReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

SReceiveSupportReward.Unmarshal = function(self, buffer)
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

return SReceiveSupportReward

