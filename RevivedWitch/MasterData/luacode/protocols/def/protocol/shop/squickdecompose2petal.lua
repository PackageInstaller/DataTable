-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/squickdecompose2petal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SQuickDecompose2Petal = dataclass("SQuickDecompose2Petal", require("framework.net.protocol"))
SQuickDecompose2Petal.ProtocolType = 3622
SQuickDecompose2Petal.MaxSize = 65535
SQuickDecompose2Petal.result = 0
SQuickDecompose2Petal.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SQuickDecompose2Petal
  ((SQuickDecompose2Petal.super).Ctor)(self, client)
end

SQuickDecompose2Petal.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  return true
end

SQuickDecompose2Petal.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SQuickDecompose2Petal

