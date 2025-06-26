-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ccloseshatteredredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCloseShatteredRedPoint = dataclass("CCloseShatteredRedPoint", require("framework.net.protocol"))
CCloseShatteredRedPoint.ProtocolType = 4134
CCloseShatteredRedPoint.MaxSize = 65535
CCloseShatteredRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCloseShatteredRedPoint
  ((CCloseShatteredRedPoint.super).Ctor)(self, client)
end

CCloseShatteredRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CCloseShatteredRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CCloseShatteredRedPoint

