-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/cdeleteread.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDeleteRead = dataclass("CDeleteRead", require("framework.net.protocol"))
CDeleteRead.ProtocolType = 1409
CDeleteRead.MaxSize = 65535
CDeleteRead.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDeleteRead
  ((CDeleteRead.super).Ctor)(self, client)
end

CDeleteRead.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CDeleteRead.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CDeleteRead

