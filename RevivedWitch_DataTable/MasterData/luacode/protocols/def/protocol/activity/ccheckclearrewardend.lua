-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ccheckclearrewardend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckClearRewardEnd = dataclass("CCheckClearRewardEnd", require("framework.net.protocol"))
CCheckClearRewardEnd.ProtocolType = 2728
CCheckClearRewardEnd.MaxSize = 65535
CCheckClearRewardEnd.activityId = 0
CCheckClearRewardEnd.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckClearRewardEnd
  ((CCheckClearRewardEnd.super).Ctor)(self, client)
end

CCheckClearRewardEnd.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  return true
end

CCheckClearRewardEnd.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckClearRewardEnd

