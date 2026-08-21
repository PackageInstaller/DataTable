-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cpaytobuyagcoinlevel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CPayToBuyAgCoinLevel = dataclass("CPayToBuyAgCoinLevel", require("framework.net.protocol"))
CPayToBuyAgCoinLevel.ProtocolType = 2441
CPayToBuyAgCoinLevel.MaxSize = 65535
CPayToBuyAgCoinLevel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CPayToBuyAgCoinLevel
  ((CPayToBuyAgCoinLevel.super).Ctor)(self, client)
end

CPayToBuyAgCoinLevel.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CPayToBuyAgCoinLevel.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CPayToBuyAgCoinLevel

