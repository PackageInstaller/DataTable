-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/sexchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SExchange = dataclass("SExchange", require("framework.net.protocol"))
SExchange.ProtocolType = 109
SExchange.MaxSize = 256
SExchange.secretKey = ""
SExchange.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SExchange
  ((SExchange.super).Ctor)(self, client)
end

SExchange.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.secretKey) then
    return false
  end
  return true
end

SExchange.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SExchange

