-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/cnewdrawcard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CNewDrawCard = dataclass("CNewDrawCard", require("framework.net.protocol"))
CNewDrawCard.ProtocolType = 1505
CNewDrawCard.MaxSize = 65535
CNewDrawCard.WaitProtocol = "protocol.notify.scancelloading"
CNewDrawCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CNewDrawCard
  ((CNewDrawCard.super).Ctor)(self, client)
end

CNewDrawCard.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CNewDrawCard.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CNewDrawCard

