-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sfreelevelgifticon.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SFreeLevelGiftIcon = dataclass("SFreeLevelGiftIcon", require("framework.net.protocol"))
SFreeLevelGiftIcon.ProtocolType = 3641
SFreeLevelGiftIcon.MaxSize = 65535
SFreeLevelGiftIcon.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SFreeLevelGiftIcon
  ((SFreeLevelGiftIcon.super).Ctor)(self, client)
end

SFreeLevelGiftIcon.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

SFreeLevelGiftIcon.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return SFreeLevelGiftIcon

