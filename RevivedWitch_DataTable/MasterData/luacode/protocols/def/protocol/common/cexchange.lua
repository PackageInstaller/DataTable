-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/common/cexchange.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CExchange = dataclass("CExchange", require("framework.net.protocol"))
CExchange.ProtocolType = 108
CExchange.MaxSize = 256
CExchange.secretKeyInMD5 = ""
CExchange.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CExchange
  ((CExchange.super).Ctor)(self, client)
end

CExchange.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.secretKeyInMD5) then
    return false
  end
  return true
end

CExchange.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CExchange

