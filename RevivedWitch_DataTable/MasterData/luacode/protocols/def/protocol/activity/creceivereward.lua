-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivereward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveReward = dataclass("CReceiveReward", require("framework.net.protocol"))
CReceiveReward.ProtocolType = 2489
CReceiveReward.MaxSize = 65535
CReceiveReward.rewardId = 0
CReceiveReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveReward
  ((CReceiveReward.super).Ctor)(self, client)
end

CReceiveReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardId) then
    return false
  end
  return true
end

CReceiveReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveReward

