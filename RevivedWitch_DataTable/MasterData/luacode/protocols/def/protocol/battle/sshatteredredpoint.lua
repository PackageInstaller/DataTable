-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/sshatteredredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SShatteredRedPoint = dataclass("SShatteredRedPoint", require("framework.net.protocol"))
SShatteredRedPoint.ProtocolType = 4133
SShatteredRedPoint.MaxSize = 65535
SShatteredRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SShatteredRedPoint
  ((SShatteredRedPoint.super).Ctor)(self, client)
end

SShatteredRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SShatteredRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SShatteredRedPoint

