-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetpointscollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetPointsCollection = dataclass("CGetPointsCollection", require("framework.net.protocol"))
CGetPointsCollection.ProtocolType = 2436
CGetPointsCollection.MaxSize = 65535
CGetPointsCollection.activityID = 0
CGetPointsCollection.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetPointsCollection
  ((CGetPointsCollection.super).Ctor)(self, client)
end

CGetPointsCollection.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  return true
end

CGetPointsCollection.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetPointsCollection

