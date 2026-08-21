-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/cdeleteone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDeleteOne = dataclass("CDeleteOne", require("framework.net.protocol"))
CDeleteOne.ProtocolType = 1408
CDeleteOne.MaxSize = 65535
CDeleteOne.uniqueId = 0
CDeleteOne.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDeleteOne
  ((CDeleteOne.super).Ctor)(self, client)
end

CDeleteOne.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  return true
end

CDeleteOne.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteOne

