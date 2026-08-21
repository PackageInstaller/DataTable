-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/copenparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local COpenParty = dataclass("COpenParty", require("framework.net.protocol"))
COpenParty.ProtocolType = 5005
COpenParty.MaxSize = 65535
COpenParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : COpenParty
  ((COpenParty.super).Ctor)(self, client)
end

COpenParty.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

COpenParty.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return COpenParty

