-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cfetchclearrewardinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CFetchClearRewardInfo = dataclass("CFetchClearRewardInfo", require("framework.net.protocol"))
CFetchClearRewardInfo.ProtocolType = 2727
CFetchClearRewardInfo.MaxSize = 65535
CFetchClearRewardInfo.activityId = 0
CFetchClearRewardInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CFetchClearRewardInfo
  ((CFetchClearRewardInfo.super).Ctor)(self, client)
end

CFetchClearRewardInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  return true
end

CFetchClearRewardInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CFetchClearRewardInfo

