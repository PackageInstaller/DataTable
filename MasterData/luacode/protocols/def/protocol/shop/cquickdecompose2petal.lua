-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cquickdecompose2petal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CQuickDecompose2Petal = dataclass("CQuickDecompose2Petal", require("framework.net.protocol"))
CQuickDecompose2Petal.ProtocolType = 3621
CQuickDecompose2Petal.MaxSize = 65535
CQuickDecompose2Petal.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CQuickDecompose2Petal
  ((CQuickDecompose2Petal.super).Ctor)(self, client)
end

CQuickDecompose2Petal.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CQuickDecompose2Petal.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CQuickDecompose2Petal

