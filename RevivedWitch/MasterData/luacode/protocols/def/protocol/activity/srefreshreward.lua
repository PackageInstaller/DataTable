-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshReward = dataclass("SRefreshReward", require("framework.net.protocol"))
SRefreshReward.ProtocolType = 2559
SRefreshReward.MaxSize = 65535
SRefreshReward.activityID = 0
SRefreshReward.leftTime = 0
SRefreshReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshReward, _ENV
  ((SRefreshReward.super).Ctor)(self, client)
  self.goodInfo = ((require("protocols.bean.protocol.activity.goodinfo")).Create)()
end

SRefreshReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (self.goodInfo):Marshal(buffer) then
    return false
  end
  return true
end

SRefreshReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  if not (self.goodInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SRefreshReward

