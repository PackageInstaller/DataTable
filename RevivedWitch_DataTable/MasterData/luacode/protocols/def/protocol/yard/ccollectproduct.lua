-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/ccollectproduct.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCollectProduct = dataclass("CCollectProduct", require("framework.net.protocol"))
CCollectProduct.ProtocolType = 2320
CCollectProduct.MaxSize = 65535
CCollectProduct.id = 0
CCollectProduct.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCollectProduct
  ((CCollectProduct.super).Ctor)(self, client)
end

CCollectProduct.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CCollectProduct.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCollectProduct

