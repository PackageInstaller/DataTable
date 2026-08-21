-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetsummerconstructionupdatelist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetSummerConstructionUpdateList = dataclass("CGetSummerConstructionUpdateList", require("framework.net.protocol"))
CGetSummerConstructionUpdateList.ProtocolType = 2473
CGetSummerConstructionUpdateList.MaxSize = 65535
CGetSummerConstructionUpdateList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetSummerConstructionUpdateList
  ((CGetSummerConstructionUpdateList.super).Ctor)(self, client)
end

CGetSummerConstructionUpdateList.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetSummerConstructionUpdateList.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetSummerConstructionUpdateList

