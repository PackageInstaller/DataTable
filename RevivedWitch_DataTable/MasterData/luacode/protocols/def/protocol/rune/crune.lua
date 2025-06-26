-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/rune/crune.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRune = dataclass("CRune", require("framework.net.protocol"))
CRune.ProtocolType = 3702
CRune.MaxSize = 65535
CRune.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRune
  ((CRune.super).Ctor)(self, client)
end

CRune.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRune.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRune

