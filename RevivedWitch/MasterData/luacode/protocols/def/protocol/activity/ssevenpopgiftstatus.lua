-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssevenpopgiftstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSevenPopGiftStatus = dataclass("SSevenPopGiftStatus", require("framework.net.protocol"))
SSevenPopGiftStatus.ProtocolType = 2746
SSevenPopGiftStatus.MaxSize = 65535
SSevenPopGiftStatus.leftTime = 0
SSevenPopGiftStatus.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSevenPopGiftStatus
  ((SSevenPopGiftStatus.super).Ctor)(self, client)
end

SSevenPopGiftStatus.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  return true
end

SSevenPopGiftStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSevenPopGiftStatus

