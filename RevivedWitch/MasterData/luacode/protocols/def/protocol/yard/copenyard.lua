-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/copenyard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenYard = dataclass("COpenYard", require("framework.net.protocol"))
COpenYard.ProtocolType = 2349
COpenYard.MaxSize = 65535
COpenYard.WaitProtocol = "protocol.notify.scancelloading"
COpenYard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenYard
  ((COpenYard.super).Ctor)(self, client)
end

COpenYard.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenYard.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenYard

