-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/copenbackpack.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenBackPack = dataclass("COpenBackPack", require("framework.net.protocol"))
COpenBackPack.ProtocolType = 2555
COpenBackPack.MaxSize = 65535
COpenBackPack.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenBackPack
  ((COpenBackPack.super).Ctor)(self, client)
end

COpenBackPack.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenBackPack.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenBackPack

