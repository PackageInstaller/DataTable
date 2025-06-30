-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cactiveactivities.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CActiveActivities = dataclass("CActiveActivities", require("framework.net.protocol"))
CActiveActivities.ProtocolType = 2444
CActiveActivities.MaxSize = 65535
CActiveActivities.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CActiveActivities
  ((CActiveActivities.super).Ctor)(self, client)
end

CActiveActivities.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CActiveActivities.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CActiveActivities

