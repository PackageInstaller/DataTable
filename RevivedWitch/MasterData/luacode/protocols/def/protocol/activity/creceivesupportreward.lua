-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivesupportreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveSupportReward = dataclass("CReceiveSupportReward", require("framework.net.protocol"))
CReceiveSupportReward.ProtocolType = 2566
CReceiveSupportReward.MaxSize = 65535
CReceiveSupportReward.rewardType = 0
CReceiveSupportReward.id = 0
CReceiveSupportReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveSupportReward
  ((CReceiveSupportReward.super).Ctor)(self, client)
end

CReceiveSupportReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveSupportReward.Unmarshal = function(self, buffer)
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

return CReceiveSupportReward

