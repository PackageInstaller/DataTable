-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ccollectall.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCollectAll = dataclass("CCollectAll", require("framework.net.protocol"))
CCollectAll.ProtocolType = 2322
CCollectAll.MaxSize = 65535
CCollectAll.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCollectAll
  ((CCollectAll.super).Ctor)(self, client)
end

CCollectAll.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CCollectAll.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CCollectAll

