-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceiveallpointsaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveAllPointsAward = dataclass("CReceiveAllPointsAward", require("framework.net.protocol"))
CReceiveAllPointsAward.ProtocolType = 2439
CReceiveAllPointsAward.MaxSize = 65535
CReceiveAllPointsAward.activityID = 0
CReceiveAllPointsAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveAllPointsAward
  ((CReceiveAllPointsAward.super).Ctor)(self, client)
end

CReceiveAllPointsAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  return true
end

CReceiveAllPointsAward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveAllPointsAward

