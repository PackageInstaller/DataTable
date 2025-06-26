-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenundecidedroad.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenUndecidedRoad = dataclass("COpenUndecidedRoad", require("framework.net.protocol"))
COpenUndecidedRoad.ProtocolType = 2479
COpenUndecidedRoad.MaxSize = 65535
COpenUndecidedRoad.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenUndecidedRoad
  ((COpenUndecidedRoad.super).Ctor)(self, client)
end

COpenUndecidedRoad.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenUndecidedRoad.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenUndecidedRoad

