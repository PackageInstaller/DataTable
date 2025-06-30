-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchecksevenpopgiftstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckSevenPopGiftStatus = dataclass("CCheckSevenPopGiftStatus", require("framework.net.protocol"))
CCheckSevenPopGiftStatus.ProtocolType = 2745
CCheckSevenPopGiftStatus.MaxSize = 65535
CCheckSevenPopGiftStatus.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckSevenPopGiftStatus
  ((CCheckSevenPopGiftStatus.super).Ctor)(self, client)
end

CCheckSevenPopGiftStatus.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CCheckSevenPopGiftStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CCheckSevenPopGiftStatus

