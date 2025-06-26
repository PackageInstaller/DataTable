-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cgetshatteredzonesinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetShatteredZonesInfo = dataclass("CGetShatteredZonesInfo", require("framework.net.protocol"))
CGetShatteredZonesInfo.ProtocolType = 2410
CGetShatteredZonesInfo.MaxSize = 65535
CGetShatteredZonesInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetShatteredZonesInfo
  ((CGetShatteredZonesInfo.super).Ctor)(self, client)
end

CGetShatteredZonesInfo.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGetShatteredZonesInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGetShatteredZonesInfo

