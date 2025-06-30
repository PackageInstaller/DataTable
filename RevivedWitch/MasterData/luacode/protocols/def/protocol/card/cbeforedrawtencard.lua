-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/card/cbeforedrawtencard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CBeforeDrawTenCard = dataclass("CBeforeDrawTenCard", require("framework.net.protocol"))
CBeforeDrawTenCard.ProtocolType = 1522
CBeforeDrawTenCard.MaxSize = 65535
CBeforeDrawTenCard.WaitProtocol = "protocol.notify.scancelloading"
CBeforeDrawTenCard.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CBeforeDrawTenCard
  ((CBeforeDrawTenCard.super).Ctor)(self, client)
end

CBeforeDrawTenCard.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CBeforeDrawTenCard.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CBeforeDrawTenCard

