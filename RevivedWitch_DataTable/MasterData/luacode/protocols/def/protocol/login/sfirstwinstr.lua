-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/sfirstwinstr.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFirstWinSTR = dataclass("SFirstWinSTR", require("framework.net.protocol"))
SFirstWinSTR.ProtocolType = 1074
SFirstWinSTR.MaxSize = 65535
SFirstWinSTR.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFirstWinSTR
  ((SFirstWinSTR.super).Ctor)(self, client)
end

SFirstWinSTR.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SFirstWinSTR.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SFirstWinSTR

