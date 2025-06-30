-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srefreshacttime.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRefreshActTime = dataclass("SRefreshActTime", require("framework.net.protocol"))
SRefreshActTime.ProtocolType = 2562
SRefreshActTime.MaxSize = 65535
SRefreshActTime.activityId = 0
SRefreshActTime.leftTime = 0
SRefreshActTime.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRefreshActTime
  ((SRefreshActTime.super).Ctor)(self, client)
end

SRefreshActTime.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  return true
end

SRefreshActTime.Unmarshal = function(self, buffer)
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
  return ret
end

return SRefreshActTime

