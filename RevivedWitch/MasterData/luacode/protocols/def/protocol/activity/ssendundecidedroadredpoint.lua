-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendundecidedroadredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendUndecidedRoadRedPoint = dataclass("SSendUndecidedRoadRedPoint", require("framework.net.protocol"))
SSendUndecidedRoadRedPoint.ProtocolType = 2611
SSendUndecidedRoadRedPoint.MaxSize = 65535
SSendUndecidedRoadRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendUndecidedRoadRedPoint
  ((SSendUndecidedRoadRedPoint.super).Ctor)(self, client)
end

SSendUndecidedRoadRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SSendUndecidedRoadRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SSendUndecidedRoadRedPoint

