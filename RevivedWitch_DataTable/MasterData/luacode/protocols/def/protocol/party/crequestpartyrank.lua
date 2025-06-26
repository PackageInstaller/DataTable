-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/crequestpartyrank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRequestPartyRank = dataclass("CRequestPartyRank", require("framework.net.protocol"))
CRequestPartyRank.ProtocolType = 5038
CRequestPartyRank.MaxSize = 65535
CRequestPartyRank.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRequestPartyRank
  ((CRequestPartyRank.super).Ctor)(self, client)
end

CRequestPartyRank.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CRequestPartyRank.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CRequestPartyRank

